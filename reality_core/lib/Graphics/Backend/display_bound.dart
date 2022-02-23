import 'device.dart';
import 'display.dart';
import 'render_target.dart';
import 'swapchain.dart';

class DisplayBound extends RenderTarget {
  final Swapchain mSwapchain;
  var mPresentMode;

  /// Construct the display bound render target using its parent [device], [frameCount], [display] to which the frames are presented to and the [presentMode].
  DisplayBound(Device device, int frameCount, Display display, var presentMode)
      : mSwapchain = Swapchain(device, display, presentMode),
        mPresentMode = presentMode,
        super(device, frameCount, display.getExtent()) {}

  /// Get the swapchain bound to this render target.
  Swapchain getSwapchain() {
    return mSwapchain;
  }

  @override
  void destroy() {}
}