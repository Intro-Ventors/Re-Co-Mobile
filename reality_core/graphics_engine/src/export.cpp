#include "export.hpp"
#include "engine.hpp"

EXPORT void *createEngine(uint32_t width, uint32_t height, const uint8_t *pImageData, const uint64_t size)
{
	return new Engine(width, height, pImageData, size);
}

EXPORT ImageData getImageDataWithCameraInputs(
	void *pointer,
	const uint8_t *pLeftEyeProjection,
	const uint8_t *pLeftEyeView,
	const uint8_t *pRightEyeProjection,
	const uint8_t *pRightEyeView)
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
	delete static_cast<Engine *>(pointer);
}

// Camera manipulation functions.

EXPORT void moveCameraForward(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().moveForward(delta);
}

EXPORT void moveCameraBackward(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().moveBackward(delta);
}

EXPORT void moveCameraLeft(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().moveLeft(delta);
}

EXPORT void moveCameraRight(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().moveRight(delta);
}

EXPORT void moveCameraUp(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().moveUp(delta);
}

EXPORT void moveCameraDown(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().moveDown(delta);
}

EXPORT void rotateCameraLeft(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().rotateLeft(delta);
}

EXPORT void rotateCameraRight(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().rotateRight(delta);
}

EXPORT void rotateCameraUp(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().rotateUp(delta);
}

EXPORT void rotateCameraDown(void *pointer, const uint64_t delta)
{
	static_cast<Engine *>(pointer)->getCamera().rotateDown(delta);
}