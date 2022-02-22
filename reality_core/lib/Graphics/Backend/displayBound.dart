import 'device.dart';
import 'display.dart';
import 'renderTarget.dart';
import 'swapchain.dart';

class DisplayBound extends RenderTarget {
  final Swapchain mSwapchain;
  var mPresentMode;

  /// Construct the display bound render target using its parent [device], [frameCount], [display] to which the frames are presented to and the [presentMode].
  DisplayBound(Device device, int frameCount, Display display, var presentMode)
      : mSwapchain = Swapchain(device, display, presentMode),
        mPresentMode = presentMode,
        super(device, frameCount, display.getExtent()) {}

  void getSwapchain() {}
}
