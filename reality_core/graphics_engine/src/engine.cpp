#include "engine.hpp"
#include "export.hpp"

#include <iostream>

#include <Firefly/AssetsLoaders/ImageLoader.hpp>
#include <Firefly/AssetsLoaders/ObjLoader.hpp>

#include "shader_code.hpp"
#include "vert_spv.h"
#include "frag_spv.h"

Engine::Engine(uint32_t width, uint32_t height, const std::string &assetPath)
	: m_Camera(Firefly::StereoCamera(glm::vec3(0.0f), (width / 2.0f) / height)), m_BasePath(assetPath)
{
	m_Instance = Firefly::Instance::create(true, VK_API_VERSION_1_1);
	m_GraphicsEngine = Firefly::GraphicsEngine::create(m_Instance);
	m_RenderTarget = Firefly::RenderTarget::create(m_GraphicsEngine, {width, height, 1}, VkFormat::VK_FORMAT_B8G8R8A8_SRGB, 1);

	m_VertexShader = Firefly::Shader::create(m_GraphicsEngine, ToShaderCode(vert_spv), VkShaderStageFlagBits::VK_SHADER_STAGE_VERTEX_BIT);
	m_FragmentShader = Firefly::Shader::create(m_GraphicsEngine, ToShaderCode(frag_spv), VkShaderStageFlagBits::VK_SHADER_STAGE_FRAGMENT_BIT);

	m_Pipeline = Firefly::GraphicsPipeline::create(m_GraphicsEngine, "Basic_Pipeline", {m_VertexShader, m_FragmentShader}, m_RenderTarget);
	m_VertexResourcePackageLeft = m_Pipeline->createPackage(m_VertexShader.get());
	m_VertexResourcePackageRight = m_Pipeline->createPackage(m_VertexShader.get());
	m_FragmentResourcePackage = m_Pipeline->createPackage(m_FragmentShader.get());

	{
		auto model = Firefly::LoadObjModel(m_GraphicsEngine, m_BasePath + "viking_room/untitled.obj");

		m_VertexBuffer = model.m_VertexBuffer;
		m_VertexCount = static_cast<uint32_t>(model.m_VertexCount);

		m_IndexBuffer = model.m_IndexBuffer;
		m_IndexCount = static_cast<uint32_t>(model.m_IndexCount);
	}

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

	m_Texture = Firefly::LoadImage(m_GraphicsEngine, m_BasePath + "viking_room/texture.png");
	m_FragmentResourcePackage->bindResources(0, {m_Texture});
}

std::shared_ptr<Firefly::Image> Engine::getRenderedImage()
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

	// Left eye.
	m_VertexBuffer->bindAsVertexBuffer(pCommandBuffer);
	m_IndexBuffer->bindAsIndexBuffer(pCommandBuffer);
	m_Pipeline->bind(pCommandBuffer, {m_VertexResourcePackageLeft.get(), m_FragmentResourcePackage.get()});

	pCommandBuffer->bindScissor(scissor);
	pCommandBuffer->bindViewport(viewport);
	pCommandBuffer->drawIndices(m_IndexCount);

	// Right eye.
	m_VertexBuffer->bindAsVertexBuffer(pCommandBuffer);
	m_IndexBuffer->bindAsIndexBuffer(pCommandBuffer);
	m_Pipeline->bind(pCommandBuffer, {m_VertexResourcePackageRight.get(), m_FragmentResourcePackage.get()});

	viewport.x = viewport.width;
	pCommandBuffer->bindViewport(viewport);
	pCommandBuffer->bindScissor(scissor);
	pCommandBuffer->drawIndices(m_IndexCount);

	m_RenderTarget->submitFrame();

	return m_RenderTarget->getColorAttachment();
}

EXPORT void *createEngine(uint32_t width, uint32_t height, const char *pBasePath)
{
	try
	{
		auto pInstance = new Engine(width, height, pBasePath);
		return pInstance;
	}
	catch (const Firefly::BackendError &e)
	{
		std::cout << e.what() << std::endl;
	}

	return nullptr;
}

EXPORT ImageData getImageData(void *pointer)
{
	auto pEngine = static_cast<Engine *>(pointer);
	const auto pImage = pEngine->getRenderedImage();
	const auto pBuffer = pImage->toBuffer();

	ImageData data;
	data.m_pImageData = reinterpret_cast<uint8_t *>(pBuffer->mapMemory());
	data.m_Width = pImage->getExtent().width;
	data.m_Height = pImage->getExtent().height;
	data.m_Depth = pImage->getExtent().depth;
	data.mPixelSize = pImage->getPixelSize();

	return data;
}

EXPORT void destroyEngine(void *pointer)
{
	auto pEngine = static_cast<Engine *>(pointer);
	delete pEngine;
}