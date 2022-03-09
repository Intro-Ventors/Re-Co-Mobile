#pragma once

#include <Firefly/Instance.hpp>
#include <Firefly/Graphics/GraphicsEngine.hpp>
#include <Firefly/Image.hpp>
#include <Firefly/Buffer.hpp>

/**
 * Engine class.
 */
class Engine
{
	std::shared_ptr<Firefly::Instance> m_pInstance = nullptr;
	std::shared_ptr<Firefly::GraphicsEngine> m_pGraphicsEngine = nullptr;
	std::shared_ptr<Firefly::Image> m_pRenderedImage = nullptr;
	std::shared_ptr<Firefly::Buffer> m_pRenderedImageBuffer = nullptr;

public:
	/**
	 * @brief Construct a new Engine object.
	 *
	 */
	Engine();

	/**
	 * @brief Copy The rendered image to a buffer and return it.
	 * 
	 * @return std::shared_ptr<Firefly::Buffer> containing the image data.
	 */
	std::shared_ptr<Firefly::Buffer> copyToBuffer();

	/**
	 * @brief Get the Rendered Image object.
	 * 
	 * @return std::shared_ptr<Firefly::Image> Containing the data. 
	 */
	std::shared_ptr<Firefly::Image> getRenderedImage() const { return m_pRenderedImage; }
};

extern "C"
{
	/**
	 * Image data structure.
	 * This structure is used to transfer data from the engine to the dart client.
	 */
	struct ImageData
	{
		uint8_t *m_pImageData = nullptr;
		uint64_t m_Width = 0;
		uint64_t m_Height = 0;
		uint64_t m_Depth = 0;
		uint64_t mPixelSize = 0;
	};
}