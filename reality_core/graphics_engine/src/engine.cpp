#include "Engine.hpp"
#include "export.hpp"

Engine::Engine()
{
	// Create the Vulkan instance.
	m_pInstance = Firefly::Instance::create(false, VK_VERSION_1_1);

	// Create the graphics engine.
	m_pGraphicsEngine = Firefly::GraphicsEngine::create(m_pInstance);
}

EXPORT void *createEngine()
{
	auto pInstance = new Engine();
	return pInstance;
}

EXPORT void destroyEngine(void *pointer)
{
	auto pEngine = static_cast<Engine *>(pointer);
	delete pEngine;
}