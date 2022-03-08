#pragma once

#include <Firefly/Instance.hpp>
#include <Firefly/Graphics/GraphicsEngine.hpp>

/**
 * Engine class.
 */
class Engine
{
	std::shared_ptr<Firefly::Instance> m_pInstance = nullptr;
	std::shared_ptr<Firefly::GraphicsEngine> m_pGraphicsEngine = nullptr;

public:
	/**
	 * @brief Construct a new Engine object.
	 * 
	 */
	Engine();
};

