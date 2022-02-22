import 'buffer.dart';
import 'displayBound.dart';
import 'graphicsPipeline.dart';
import 'image.dart';
import 'instance.dart';
import 'offScreen.dart';
import 'oneTimeCommandBuffer.dart';
import 'renderTarget.dart';
import 'shader.dart';
import 'display.dart';
import 'utilities.dart';

class Device {
  final Instance mInstance;

  /// Construct the device using its parent [instance].
  Device(Instance instance) : mInstance = instance {}

  void getLogicalDevice() {}
  void getPhysicalDevice() {}

  /// Create a new buffer object.
  Buffer createBuffer(int size, var bufferType) {
    return Buffer(this, size, bufferType);
  }

  /// Create a new image object.
  Image createImage(Extent3D extent, var imageType, int layers, int mipLevel) {
    return Image(this, extent, imageType, layers, mipLevel);
  }

  /// Create a new shader.
  Shader createShader(var code, var type) {
    return Shader(this, code, type);
  }

  /// Create a new graphics pipeline.
  GraphicsPipeline createGraphicsPipeline(
      var specification, var shaders, RenderTarget renderTarget) {
    return GraphicsPipeline(this, specification, shaders, renderTarget);
  }

  /// Create a new one time command buffer.
  /// These command buffers are scope based and is intended to be used as a single shot.
  OneTimeCommandBuffer createOneTimeCommandBuffer() {
    return OneTimeCommandBuffer(this);
  }

  /// Create an off screen render target.
  OffScreen createOffScreenRenderTarget(int imageCount, Extent2D extent) {
    return OffScreen(this, imageCount, extent);
  }

  /// Create a display bound render target.
  DisplayBound createDisplayBoundRenderTarget(
      Display display, int frameCount, var presentMode) {
    return DisplayBound(this, frameCount, display, presentMode);
  }

  void createDescriptorSetManager() {}
}
