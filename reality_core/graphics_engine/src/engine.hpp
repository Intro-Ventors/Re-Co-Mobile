#pragma once

#include <Firefly/Instance.hpp>
#include <Firefly/Graphics/GraphicsEngine.hpp>
#include <Firefly/Graphics/RenderTarget.hpp>
#include <Firefly/Graphics/GraphicsPipeline.hpp>
#include <Firefly/Maths/MonoCamera.hpp>
#include <Firefly/Maths/StereoCamera.hpp>

/**
 * Engine class.
 */
class Engine
{
	Firefly::StereoCamera m_Camera;

	std::string m_BasePath;

	std::shared_ptr<Firefly::Instance> m_Instance = nullptr;
	std::shared_ptr<Firefly::GraphicsEngine> m_GraphicsEngine = nullptr;
	std::shared_ptr<Firefly::RenderTarget> m_RenderTarget = nullptr;

	std::shared_ptr<Firefly::Shader> m_VertexShader = nullptr;
	std::shared_ptr<Firefly::Shader> m_FragmentShader = nullptr;
	std::shared_ptr<Firefly::GraphicsPipeline> m_Pipeline = nullptr;

	std::shared_ptr<Firefly::Buffer> m_VertexBuffer = nullptr;
	std::shared_ptr<Firefly::Buffer> m_IndexBuffer = nullptr;

	std::shared_ptr<Firefly::Buffer> m_LeftEyeUniform = nullptr;
	std::shared_ptr<Firefly::Buffer> m_RightEyeUniform = nullptr;

	std::shared_ptr<Firefly::Buffer> m_UniformBuffer = nullptr;
	std::shared_ptr<Firefly::Image> m_Texture = nullptr;

	std::shared_ptr<Firefly::Package> m_VertexResourcePackageLeft = nullptr;
	std::shared_ptr<Firefly::Package> m_VertexResourcePackageRight = nullptr;
	std::shared_ptr<Firefly::Package> m_FragmentResourcePackage = nullptr;

	uint32_t m_VertexCount = 0;
	uint32_t m_IndexCount = 0;

public:
	/**
	 * @brief Construct a new Engine object.
	 *
	 * @param width The render target width.
	 * @param height The render target height.
	 */
	Engine(uint32_t width, uint32_t height, const std::string &assetPath);

	/**
	 * @brief Get the Rendered Image object.
	 *
	 * @return std::shared_ptr<Firefly::Image> Containing the data.
	 */
	std::shared_ptr<Firefly::Image> getRenderedImage();
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