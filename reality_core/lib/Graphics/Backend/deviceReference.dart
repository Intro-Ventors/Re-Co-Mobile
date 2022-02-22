import 'device.dart';

class DeviceReference {
  final Device mDevice;

  /// Construct the device reference using the parent [device].
  DeviceReference(Device device) : mDevice = device;

  /// Get the parent device.
  Device getDevice() {
    return mDevice;
  }
}
