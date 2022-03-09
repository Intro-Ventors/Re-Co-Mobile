#include "engine.hpp"
#include "export.hpp"

#include <iostream>

#include "shader_code.hpp"
#include "vert_spv.h"

Engine::Engine(uint32_t width, uint32_t height)
{
	// Create the Vulkan instance.
	m_pInstance = Firefly::Instance::create(false, VK_API_VERSION_1_1);

	// Create the graphics engine.
	m_pGraphicsEngine = Firefly::GraphicsEngine::create(m_pInstance);

	// Create the render target.
	m_pRenderTarget = Firefly::RenderTarget::create(m_pGraphicsEngine, {width, height, 1});

	// Shader test.
	m_pVertexShader = Firefly::Shader::create(m_pGraphicsEngine, ToShaderCode(vert_spv), VkShaderStageFlagBits::VK_SHADER_STAGE_VERTEX_BIT);
}

std::shared_ptr<Firefly::Buffer> Engine::copyToBuffer()
{
	m_pRenderedImageBuffer = getRenderedImage()->toBuffer();
	return m_pRenderedImageBuffer;
}

EXPORT void *createEngine(uint32_t width, uint32_t height)
{
	try
	{
		auto pInstance = new Engine(width, height);
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

EXPORT void destroyEngine(void *pointer)
{
	auto pEngine = static_cast<Engine *>(pointer);
	delete pEngine;
}