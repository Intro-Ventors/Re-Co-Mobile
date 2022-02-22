import 'device.dart';
import 'display.dart';
import 'utilities.dart';

class Instance {
  void getInstance() {}
  void getDebugger() {}

  /// Create a new device.
  Device createDevice() {
    return Device();
  }

  /// Create a new display with the [extent].
  Display createDisplay(Extent2D extent) {
    return Display();
  }
}
