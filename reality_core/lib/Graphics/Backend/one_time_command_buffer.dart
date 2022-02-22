import 'device.dart';
import 'device_reference.dart';

class OneTimeCommandBuffer extends DeviceReference {
  /// Construct the one time command buffer using its parent [device].
  OneTimeCommandBuffer(Device device) : super(device) {}

  void getCommandBuffer() {}
  void getCommandPool() {}

  @override
  void destroy() {}
}
