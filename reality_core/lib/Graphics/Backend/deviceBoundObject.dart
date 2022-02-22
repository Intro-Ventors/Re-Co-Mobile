import 'device.dart';
import 'deviceReference.dart';

class DeviceBoundObject extends DeviceReference {
  var mMemoryType;

  /// Construct the device bound object using the parent [device] and its [memoryType].
  DeviceBoundObject(Device device, var memoryType)
      : mMemoryType = memoryType,
        super(device) {}

  void getDeviceMemory() {}
}
