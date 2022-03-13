#include "export.hpp"
#include "engine.hpp"

EXPORT void *createEngine(uint32_t width, uint32_t height, const unsigned char *pImageData, const uint64_t size)
{
	return new Engine(width, height, pImageData, size);
}

EXPORT ImageData getImageDataWithCameraInputs(
	void *pointer,
	const unsigned char *pLeftEyeProjection,
	const unsigned char *pLeftEyeView,
	const unsigned char *pRightEyeProjection,
	const unsigned char *pRightEyeView)
{
	RawCameraData cameraData;
	cameraData.m_pLeftEyeProjection = pLeftEyeProjection;
	cameraData.m_pLeftEyeView = pLeftEyeView;
	cameraData.m_pRightEyeProjection = pRightEyeProjection;
	cameraData.m_pRightEyeView = pRightEyeView;

	auto pEngine = static_cast<Engine *>(pointer);
	const auto pImage = pEngine->getColorImage();
	const auto pBuffer = pEngine->drawScene(cameraData);

	ImageData data;
	data.m_pImageData = reinterpret_cast<uint8_t *>(pBuffer->mapMemory());
	data.m_Width = pImage->getExtent().width;
	data.m_Height = pImage->getExtent().height;
	data.m_Depth = pImage->getExtent().depth;
	data.mPixelSize = pImage->getPixelSize();

	pBuffer->unmapMemory();

	return data;
}

EXPORT ImageData getImageData(void *pointer)
{
	auto pEngine = static_cast<Engine *>(pointer);
	const auto pImage = pEngine->getColorImage();
	const auto pBuffer = pEngine->drawScene();

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