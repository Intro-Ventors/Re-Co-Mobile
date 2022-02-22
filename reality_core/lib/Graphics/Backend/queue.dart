import 'device.dart';
import 'deviceReference.dart';

class Queue extends DeviceReference {
  /// Create the queue using the [device] its bound to.
  Queue(Device device) : super(device) {}

  void getGraphicsQueue() {}
  void getTransferQueue() {}
  void getGraphicsFamily() {}
  void getTransferFamily() {}
  bool isComplete() {
    return false;
  }
}
