import 'device.dart';
import 'device_reference.dart';

class Queue extends DeviceReference {
  int? mGraphicsFamily;
  int? mTransferFamily;

  /// Create the queue using the [device] its bound to.
  Queue(Device device) : super(device) {}

  void getGraphicsQueue() {}
  void getTransferQueue() {}

  /// Get the graphics family. The return can be null.
  int? getGraphicsFamily() {
    return mGraphicsFamily;
  }

  /// Get the transfer family. The return can be null.
  int? getTransferFamily() {
    return mTransferFamily;
  }

  /// Check if the queue is complete and contains the data we need.
  /// A queue is considered as complete if both the graphics and transfer families are not null.
  bool isComplete() {
    return mGraphicsFamily != null && mTransferFamily != null;
  }

  @override
  void destroy() {}
}
