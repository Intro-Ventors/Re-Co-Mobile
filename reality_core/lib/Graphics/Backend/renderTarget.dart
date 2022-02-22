class RenderTarget {
  int mFrameIndex = 0;
  int mFrameCount = 0;

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
