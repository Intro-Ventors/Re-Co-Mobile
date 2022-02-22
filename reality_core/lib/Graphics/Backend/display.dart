import 'instance.dart';
import 'utilities.dart';

class Display {
  final Instance mInstance;
  final Extent2D mExtent;

  /// Construct the display using the [instance] and [extent].
  Display(Instance instance, Extent2D extent)
      : mInstance = instance,
        mExtent = extent {}

  /// Get the extent of the display.
  Extent2D getExtent() {
    return mExtent;
  }

  void getSurface() {}
  void getWindows() {}
  void isDeviceCompatible(device) {}
}
