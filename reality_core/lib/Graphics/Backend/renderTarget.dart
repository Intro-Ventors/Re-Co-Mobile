import 'device.dart';
import 'deviceReference.dart';
import 'utilities.dart';

class RenderTarget extends DeviceReference {
  int mFrameIndex = 0;
  final int mFrameCount;
  final Extent2D mExtent;

  /// Construct the render target using the [device], [frameCount] and the [extent].
  RenderTarget(Device device, int frameCount, Extent2D extent)
      : mFrameCount = frameCount,
        mExtent = extent,
        super(device) {}

  void getFrameBuffers() {}
  void getRenderPass() {}

  void getAttachments() {}
  void getCommandPool() {}
  void getCommandBuffers() {}
  void getFences() {}
  void getImageAvailableSemaphores() {}
  void getRenderFinishedSemaphores() {}

  /// Get the current frame index.
  int getCurrentFrameIndex() {
    return mFrameIndex;
  }

  /// Get the frame count. This represents the number of frame buffers in the render target.
  int getFrameCount() {
    return mFrameCount;
  }

  void prepareFrame() {}
  void renderFrame() {}
}
