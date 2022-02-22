import 'buffer.dart';
import 'descriptor_set_manager.dart';
import 'display_bound.dart';
import 'graphics_pipeline.dart';
import 'image.dart';
import 'instance.dart';
import 'instance_bound_object.dart';
import 'offScreen.dart';
import 'one_time_command_buffer.dart';
import 'render_target.dart';
import 'shader.dart';
import 'display.dart';
import 'utilities.dart';

class Device extends InstanceBoundObject {
  /// Construct the device using its parent [instance].
  Device(Instance instance) : super(instance) {}

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
  Shader createShader(List<int> code, var type) {
    return Shader(this, code, type);
  }

  /// Create a new graphics pipeline.
  GraphicsPipeline createGraphicsPipeline(
      var specification, List<Shader> shaders, RenderTarget renderTarget) {
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

  /// Create a descriptor set manager.
  DescriptorSetManager createDescriptorSetManager() {
    return DescriptorSetManager(this);
  }

  @override
  void destroy() {}
}
