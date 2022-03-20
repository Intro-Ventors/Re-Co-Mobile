#include "engine.hpp"

#include <Firefly/AssetsLoaders/ImageLoader.hpp>
#include <Firefly/AssetsLoaders/ObjLoader.hpp>

#include <cassert>
#include <iostream>

#include "shader_code.hpp"
#include "vert_spv.h"
#include "frag_spv.h"

#include <android/log.h>

static void Logger(Firefly::Utility::LogLevel level, const std::string_view &message)
{
	switch (level)
	{
	case Firefly::Utility::LogLevel::Information:
		__android_log_print(ANDROID_LOG_INFO, "Firefly", "%s", message.data());
		break;

	case Firefly::Utility::LogLevel::Warning:
		__android_log_print(ANDROID_LOG_WARN, "Firefly", "%s", message.data());
		break;

	case Firefly::Utility::LogLevel::Error:
		__android_log_print(ANDROID_LOG_ERROR, "Firefly", "%s", message.data());
		break;

	case Firefly::Utility::LogLevel::Fatal:
		__android_log_print(ANDROID_LOG_FATAL, "Firefly", "%s", message.data());
		break;

	default:
		break;
	}
}

Engine::Engine(uint32_t width, uint32_t height, const unsigned char *pImageData, const uint64_t size)
	: m_Camera(Firefly::StereoCamera(glm::vec3(0.0f), (width / 2.0f) / height))
{
	__android_log_print(ANDROID_LOG_INFO, "Engine", "Setting the logger method.");
	Firefly::Utility::Logger::setLoggerMethod(Logger);

	// Create the instance.
	__android_log_print(ANDROID_LOG_INFO, "Engine", "Attempting to create the instance.");
	m_Instance = Firefly::Instance::create(false);
	assert(m_Instance && "Failed to create the instance!");
	__android_log_print(ANDROID_LOG_INFO, "Engine", "Instance created.");

	// Create the engine.
	m_GraphicsEngine = Firefly::GraphicsEngine::create(m_Instance);
	assert(m_GraphicsEngine && "Failed to create the graphics engine!");
	__android_log_print(ANDROID_LOG_INFO, "Engine", "Graphics engine created.");

	// Create the render target.
	m_RenderTarget = Firefly::RenderTarget::create(m_GraphicsEngine, {width, height, 1}, VkFormat::VK_FORMAT_R8G8B8A8_SRGB, 1);
	assert(m_RenderTarget && "Failed to create the render target!");
	__android_log_print(ANDROID_LOG_INFO, "Engine", "Render target created.");

	m_VertexShader = Firefly::Shader::create(m_GraphicsEngine, ToShaderCode(vert_spv), VkShaderStageFlagBits::VK_SHADER_STAGE_VERTEX_BIT);
	assert(m_VertexShader && "Failed to create the vertex shader!");

	m_FragmentShader = Firefly::Shader::create(m_GraphicsEngine, ToShaderCode(frag_spv), VkShaderStageFlagBits::VK_SHADER_STAGE_FRAGMENT_BIT);
	assert(m_FragmentShader && "Failed to create the fragment shader!");

	m_Pipeline = Firefly::GraphicsPipeline::create(m_GraphicsEngine, "Basic_Pipeline", {m_VertexShader, m_FragmentShader}, m_RenderTarget);
	assert(m_Pipeline && "Failed to create the graphics pipeline!");

	// Create and check if we created the packages correctly.
	m_VertexResourcePackageLeft = m_Pipeline->createPackage(m_VertexShader.get());
	assert(m_VertexResourcePackageLeft && "Failed to create the vertex resource package left!");
	m_VertexResourcePackageRight = m_Pipeline->createPackage(m_VertexShader.get());
	assert(m_VertexResourcePackageRight && "Failed to create the vertex resource package right!");
	m_FragmentResourcePackage = m_Pipeline->createPackage(m_FragmentShader.get());
	assert(m_FragmentResourcePackage && "Failed to create the fragment resource package!");

	loadQuad();

	m_UniformBuffer = Firefly::Buffer::create(m_GraphicsEngine, sizeof(glm::mat4), Firefly::BufferType::Uniform);
	auto &modelMatrix = *reinterpret_cast<glm::mat4 *>(m_UniformBuffer->mapMemory());
	modelMatrix = glm::rotate(glm::mat4(1.0f), glm::radians(180.0f), glm::vec3(0.0f, 0.0f, 1.0f));
	m_UniformBuffer->unmapMemory();

	m_LeftEyeUniform = Firefly::CameraMatrix::createBuffer(m_GraphicsEngine);
	m_RightEyeUniform = Firefly::CameraMatrix::createBuffer(m_GraphicsEngine);

	m_VertexResourcePackageLeft->bindResources(0, {m_LeftEyeUniform});
	m_VertexResourcePackageLeft->bindResources(1, {m_UniformBuffer});
	m_VertexResourcePackageRight->bindResources(0, {m_RightEyeUniform});
	m_VertexResourcePackageRight->bindResources(1, {m_UniformBuffer});

	m_Texture = Firefly::LoadImageFromMemory(m_GraphicsEngine, pImageData, size, Firefly::ImageDataFormat::PNG);
	m_FragmentResourcePackage->bindResources(0, {m_Texture});
}

std::shared_ptr<Firefly::Buffer> Engine::drawScene()
{
	m_Camera.update();
	m_Camera.copyToBuffer(m_LeftEyeUniform.get(), m_RightEyeUniform.get());

	VkViewport viewport = {};
	viewport.width = static_cast<float>(m_RenderTarget->getExtent().width) / 2;
	viewport.height = static_cast<float>(m_RenderTarget->getExtent().height);
	viewport.minDepth = 0.0f;
	viewport.maxDepth = 1.0f;
	viewport.x = 0.0f;
	viewport.y = 0.0f;

	VkRect2D scissor = {};
	scissor.extent.width = m_RenderTarget->getExtent().width;
	scissor.extent.height = m_RenderTarget->getExtent().height;
	scissor.offset.x = 0;
	scissor.offset.y = 0;

	const auto pCommandBuffer = m_RenderTarget->setupFrame(Firefly::CreateClearValues(Firefly::CreateColor256(0), Firefly::CreateColor256(0), Firefly::CreateColor256(0)));

	pCommandBuffer->bindVertexBuffer(m_VertexBuffer.get());
	pCommandBuffer->bindIndexBuffer(m_IndexBuffer.get());
	pCommandBuffer->bindGraphicsPipeline(m_Pipeline.get(), { m_VertexResourcePackageLeft.get(), m_FragmentResourcePackage.get() });

	// Left eye. 
	pCommandBuffer->bindScissor(scissor);
	pCommandBuffer->bindViewport(viewport);
	pCommandBuffer->drawIndices(m_IndexCount);

	// Right eye.
	viewport.x = viewport.width;
	pCommandBuffer->bindViewport(viewport);
	pCommandBuffer->bindScissor(scissor);
	pCommandBuffer->drawIndices(m_IndexCount);

	m_RenderTarget->submitFrame();

	m_ImageBuffer = m_RenderTarget->getColorAttachment()->toBuffer();
	return m_ImageBuffer;
}

std::shared_ptr<Firefly::Buffer> Engine::drawScene(RawCameraData cameraData)
{
	m_Camera.update();
	m_Camera.copyToBuffer(m_LeftEyeUniform.get(), m_RightEyeUniform.get());

	// Copy the camera data.
	{
		{
			auto pDataPointer = m_LeftEyeUniform->mapMemory();
			std::copy(cameraData.m_pLeftEyeProjection, cameraData.m_pLeftEyeProjection + sizeof(glm::mat4), reinterpret_cast<unsigned char *>(pDataPointer));
			pDataPointer += sizeof(glm::mat4);

			std::copy(cameraData.m_pLeftEyeView, cameraData.m_pLeftEyeView + sizeof(glm::mat4), reinterpret_cast<unsigned char *>(pDataPointer));
			m_LeftEyeUniform->unmapMemory();
		}

		{
			auto pDataPointer = m_RightEyeUniform->mapMemory();
			std::copy(cameraData.m_pRightEyeProjection, cameraData.m_pRightEyeProjection + sizeof(glm::mat4), reinterpret_cast<unsigned char *>(pDataPointer));
			pDataPointer += sizeof(glm::mat4);

			std::copy(cameraData.m_pRightEyeView, cameraData.m_pRightEyeView + sizeof(glm::mat4), reinterpret_cast<unsigned char *>(pDataPointer));
			m_RightEyeUniform->unmapMemory();
		}
	}

	VkViewport viewport = {};
	viewport.width = static_cast<float>(m_RenderTarget->getExtent().width) / 2;
	viewport.height = static_cast<float>(m_RenderTarget->getExtent().height);
	viewport.minDepth = 0.0f;
	viewport.maxDepth = 1.0f;
	viewport.x = 0.0f;
	viewport.y = 0.0f;

	VkRect2D scissor = {};
	scissor.extent.width = m_RenderTarget->getExtent().width;
	scissor.extent.height = m_RenderTarget->getExtent().height;
	scissor.offset.x = 0;
	scissor.offset.y = 0;

	const auto pCommandBuffer = m_RenderTarget->setupFrame(Firefly::CreateClearValues(Firefly::CreateColor256(0), Firefly::CreateColor256(0), Firefly::CreateColor256(0)));

	pCommandBuffer->bindVertexBuffer(m_VertexBuffer.get());
	pCommandBuffer->bindIndexBuffer(m_IndexBuffer.get());
	pCommandBuffer->bindGraphicsPipeline(m_Pipeline.get(), { m_VertexResourcePackageLeft.get(), m_FragmentResourcePackage.get() });

	// Left eye. 
	pCommandBuffer->bindScissor(scissor);
	pCommandBuffer->bindViewport(viewport);
	pCommandBuffer->drawIndices(m_IndexCount);

	// Right eye.
	viewport.x = viewport.width;
	pCommandBuffer->bindViewport(viewport);
	pCommandBuffer->bindScissor(scissor);
	pCommandBuffer->drawIndices(m_IndexCount);

	m_RenderTarget->submitFrame();

	m_ImageBuffer = m_RenderTarget->getColorAttachment()->toBuffer();
	return m_ImageBuffer;
}

void Engine::loadVikingRoomModel()
{
	auto model = Firefly::LoadObjModel(m_GraphicsEngine, m_BasePath + "viking_room/untitled.obj");

	m_VertexBuffer = model.m_VertexBuffer;
	m_VertexCount = static_cast<uint32_t>(model.m_VertexCount);

	m_IndexBuffer = model.m_IndexBuffer;
	m_IndexCount = static_cast<uint32_t>(model.m_IndexCount);
}

void Engine::loadQuad()
{
	{
		const auto vertices = generateQuadVertices();
		m_VertexCount = static_cast<uint32_t>(vertices.size());
		auto pStagingVertexBuffer = Firefly::Buffer::create(m_GraphicsEngine, m_VertexCount * sizeof(Firefly::ObjVertex), Firefly::BufferType::Staging);

		std::copy(vertices.begin(), vertices.end(), reinterpret_cast<Firefly::ObjVertex *>(pStagingVertexBuffer->mapMemory()));
		pStagingVertexBuffer->unmapMemory();

		m_VertexBuffer = Firefly::Buffer::create(m_GraphicsEngine, m_VertexCount * sizeof(Firefly::ObjVertex), Firefly::BufferType::Vertex);
		m_VertexBuffer->fromBuffer(pStagingVertexBuffer.get());
	}

	{
		const auto indices = generateQuadIndices();
		m_IndexCount = static_cast<uint32_t>(indices.size());
		auto pStagingIndexBuffer = Firefly::Buffer::create(m_GraphicsEngine, m_IndexCount * sizeof(uint32_t), Firefly::BufferType::Staging);

		std::copy(indices.begin(), indices.end(), reinterpret_cast<uint32_t *>(pStagingIndexBuffer->mapMemory()));
		pStagingIndexBuffer->unmapMemory();

		m_IndexBuffer = Firefly::Buffer::create(m_GraphicsEngine, m_IndexCount * sizeof(uint32_t), Firefly::BufferType::Index);
		m_IndexBuffer->fromBuffer(pStagingIndexBuffer.get());
	}
}

std::vector<Firefly::ObjVertex> Engine::generateQuadVertices() const
{
	return {
		{{-0.5f, -0.5f, 0.0f}, {1.0f, 0.0f, 0.0f, 1.0f}, {1.0f, 0.0f}},
		{{0.5f, -0.5f, 0.0f}, {0.0f, 1.0f, 0.0f, 1.0f}, {0.0f, 0.0f}},
		{{0.5f, 0.5f, 0.0f}, {0.0f, 0.0f, 1.0f, 1.0f}, {0.0f, 1.0f}},
		{{-0.5f, 0.5f, 0.0f}, {1.0f, 1.0f, 1.0f, 1.0f}, {1.0f, 1.0f}}};
}

std::vector<uint32_t> Engine::generateQuadIndices() const
{
	return {
		0, 1, 2,
		2, 3, 0};
}