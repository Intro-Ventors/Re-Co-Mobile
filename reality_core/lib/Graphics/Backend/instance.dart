import 'backend_object.dart';
import 'device.dart';
import 'display.dart';
import 'utilities.dart';

class Instance extends BackendObject {
  final bool isValidationEnabled;

  /// Construct the instance.
  /// If [enableValidation] is set to true, it will generate the required instance extensions and the validation layers
  /// along with the debug messenger. This might be slow and is not recommended when deploying the application, as its
  /// not needed then.
  Instance(bool enableValidation) : isValidationEnabled = enableValidation {}

  void getInstance() {}
  void getDebugger() {}

  /// Create a new device.
  Device createDevice() {
    return Device(this);
  }

  /// Create a new display with the [extent].
  Display createDisplay(Extent2D extent) {
    return Display(this, extent);
  }

  @override
  void destroy() {}
}
