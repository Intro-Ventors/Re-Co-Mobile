import 'buffer.dart';
import 'displayBound.dart';
import 'graphicsPipeline.dart';
import 'image.dart';
import 'offScreen.dart';
import 'oneTimeCommandBuffer.dart';
import 'renderTarget.dart';
import 'shader.dart';
import 'display.dart';
import 'utilities.dart';

class Device {
  void getLogicalDevice() {}
  void getPhysicalDevice() {}

  /// Create a new buffer object.
  Buffer createBuffer(int size, bufferType) {
    return Buffer();
  }

  /// Create a new image object.
  Image createImage(Extent3D extent, imageType, int layers, int mipLevel) {
    return Image();
  }

  /// Create a new shader.
  Shader createShader(code, type) {
    return Shader();
  }

  /// Create a new graphics pipeline.
  GraphicsPipeline createGraphicsPipeline(
      specification, var shaders, RenderTarget renderTarget) {
    return GraphicsPipeline();
  }

  /// Create a new one time command buffer.
  /// These command buffers are scope based and is intended to be used as a single shot.
  OneTimeCommandBuffer createOneTimeCommandBuffer() {
    return OneTimeCommandBuffer();
  }

  /// Create an off screen render target.
  OffScreen createOffScreenRenderTarget(int imageCount, Extent2D extent) {
    return OffScreen();
  }

  /// Create a display bound render target.
  DisplayBound createDisplayBoundRenderTarget(Display display, presentMode) {
    return DisplayBound();
  }

  void createDescriptorSetManager() {}
}
