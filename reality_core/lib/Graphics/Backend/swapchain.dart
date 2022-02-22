import 'device.dart';
import 'deviceReference.dart';
import 'display.dart';

class Swapchain extends DeviceReference {
  final Display mDisplay;
  var mPresentMode;
  var mImages;

  /// Construct the swapchain using the parent [device] and the [display] to which the frames are presented to as specified by the [presentMode]
  Swapchain(Device device, Display display, var presentMode)
      : mDisplay = display,
        mPresentMode = presentMode,
        super(device) {}

  /// Get the number of images stored in the images vector.
  int getImageCount() {
    return 0;
  }

  void getSwapChain() {}

  void getSwapChainImages() {}

  void getDisplay() {}
}
