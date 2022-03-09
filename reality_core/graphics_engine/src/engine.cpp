#include "engine.hpp"
#include "export.hpp"

#include <iostream>

#include "shader_code.hpp"
#include "vert_spv.h"

Engine::Engine()
{
	// Create the Vulkan instance.
	m_pInstance = Firefly::Instance::create(false, VK_API_VERSION_1_1);

	// Create the graphics engine.
	m_pGraphicsEngine = Firefly::GraphicsEngine::create(m_pInstance);

	// Image Test.
	m_pRenderedImage = Firefly::Image::create(m_pGraphicsEngine, {1280, 720, 1}, VkFormat::VK_FORMAT_B8G8R8A8_SRGB, Firefly::ImageType::TwoDimension);

	// Shader test.
	m_pVertexShader = Firefly::Shader::create(m_pGraphicsEngine, ToShaderCode(vert_spv), VkShaderStageFlagBits::VK_SHADER_STAGE_VERTEX_BIT);
}

std::shared_ptr<Firefly::Buffer> Engine::copyToBuffer()
{
	m_pRenderedImageBuffer = m_pRenderedImage->toBuffer();
	return m_pRenderedImageBuffer;
}

EXPORT void *createEngine()
{
	try
	{
		auto pInstance = new Engine();
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
	const auto pBuffer = pEngine->copyToBuffer();

	ImageData data;
	data.m_pImageData = reinterpret_cast<uint8_t *>(pBuffer->mapMemory());
	data.m_Width = pImage->getExtent().width;
	data.m_Height = pImage->getExtent().height;
	data.m_Depth = pImage->getExtent().depth;
	data.mPixelSize = pImage->getPixelSize();

	return data;
}

EXPORT ShaderInfo getVertexShaderInfo(void *pointer)
{
	auto pEngine = static_cast<Engine *>(pointer);
	const auto pShader = pEngine->getVertexShader();

	ShaderInfo info = {};
	info.m_BindingCount = pShader->getBindings().size();
	info.m_InputAttributeCount = pShader->getInputAttributes().size();
	info.m_pInputAttributes = pShader->getInputAttributes().data();
	info.m_OutputAttributeCount = pShader->getOutputAttributes().size();
	info.m_pOutputAttributes = pShader->getOutputAttributes().data();

	return info;
}

EXPORT void destroyEngine(void *pointer)
{
	auto pEngine = static_cast<Engine *>(pointer);
	delete pEngine;
}