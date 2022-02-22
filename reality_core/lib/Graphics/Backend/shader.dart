import 'device.dart';
import 'device_reference.dart';

class Shader extends DeviceReference {
  var mType;

  /// Construct the shader using its parent [device], the shader [code] and its [type].
  Shader(Device device, var code, var type)
      : mType = type,
        super(device) {}

  void getModule() {}
  void getDescriptorLayout() {}

  @override
  void destroy() {}
}
