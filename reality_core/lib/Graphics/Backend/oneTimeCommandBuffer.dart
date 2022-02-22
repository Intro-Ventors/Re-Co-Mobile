import 'device.dart';
import 'deviceReference.dart';

class OneTimeCommandBuffer extends DeviceReference {
  /// Construct the one time command buffer using its parent [device].
  OneTimeCommandBuffer(Device device) : super(device) {}

  void getCommandBuffer() {}
  void getCommandPool() {}
}
