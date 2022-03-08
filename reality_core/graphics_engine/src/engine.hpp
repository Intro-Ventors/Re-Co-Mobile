#pragma once

#include <GraphicsCore/Instance.hpp>

/**
 * Engine class.
 */
class Engine
{
	std::shared_ptr<GraphicsCore::Instance> m_pInstance = nullptr;

public:
	/**
	 * @brief Construct a new Engine object.
	 * 
	 */
	Engine();
};

