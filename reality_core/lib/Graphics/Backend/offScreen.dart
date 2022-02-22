import 'device.dart';
import 'renderTarget.dart';
import 'utilities.dart';

class OffScreen extends RenderTarget {
  OffScreen(Device device, int frameCount, Extent2D extent)
      : super(device, frameCount, extent) {}

  void getRenderedImage() {}
}
