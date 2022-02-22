import 'device.dart';
import 'device_reference.dart';

abstract class DeviceBoundObject extends DeviceReference {
  var mMemoryType;

  /// Construct the device bound object using the parent [device] and its [memoryType].
  DeviceBoundObject(Device device, var memoryType)
      : mMemoryType = memoryType,
        super(device) {}

  void getDeviceMemory() {}
}
