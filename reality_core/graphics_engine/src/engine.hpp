#pragma once

#include <Firefly/Instance.hpp>
#include <Firefly/Graphics/GraphicsEngine.hpp>
#include <Firefly/Graphics/RenderTarget.hpp>
#include <Firefly/Graphics/GraphicsPipeline.hpp>
#include <Firefly/Maths/MonoCamera.hpp>
#include <Firefly/Maths/StereoCamera.hpp>
#include <Firefly/AssetsLoaders/Types.hpp>

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

	/**
	 * Raw camera data structure.
	 * This struct contains the raw camera data sent from the client application.
	 */
	struct RawCameraData
	{
		const unsigned char *m_pLeftEyeProjection = nullptr;
		const unsigned char *m_pLeftEyeView = nullptr;
		const unsigned char *m_pRightEyeProjection = nullptr;
		const unsigned char *m_pRightEyeView = nullptr;
	};
}

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

	std::shared_ptr<Firefly::Buffer> m_ImageBuffer = nullptr;

	uint32_t m_VertexCount = 0;
	uint32_t m_IndexCount = 0;

public:
	/**
	 * @brief Construct a new Engine object.
	 *
	 * @param width The render target width.
	 * @param height The render target height.
	 * @param pImageData The image data pointer.
	 * @param size The image data size.
	 */
	Engine(uint32_t width, uint32_t height, const unsigned char *pImageData, const uint64_t size);

	/**
	 * @brief Draw the scene.
	 *
	 * @return std::shared_ptr<Firefly::Buffer> Containing the data.
	 */
	std::shared_ptr<Firefly::Buffer> drawScene();

	/**
	 * @brief Draw the scene.
	 *
	 * @param cameraData The camear data sent by the client application.
	 * @return std::shared_ptr<Firefly::Buffer> Containing the data.
	 */
	std::shared_ptr<Firefly::Buffer> drawScene(RawCameraData cameraData);

	/**
	 * @brief Get the Color Image object
	 *
	 * @return std::shared_ptr<Firefly::Image>
	 */
	std::shared_ptr<Firefly::Image> getColorImage() const { return m_RenderTarget->getColorAttachment(); }

	/**
	 * @brief Get the Camera object.
	 * 
	 * @return Firefly::StereoCamera& 
	 */
	Firefly::StereoCamera& getCamera() { return m_Camera; }

private:
	void loadVikingRoomModel();
	void loadQuad();

	std::vector<Firefly::ObjVertex> generateQuadVertices() const;
	std::vector<uint32_t> generateQuadIndices() const;
};