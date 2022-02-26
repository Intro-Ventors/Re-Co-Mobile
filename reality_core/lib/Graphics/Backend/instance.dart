import 'dart:ffi';

import 'package:vulkan/vulkan.dart';
import 'package:ffi/ffi.dart';

import 'backend_object.dart';
import 'device.dart';
import 'display.dart';
import 'utilities.dart';

class Instance extends BackendObject {
  final bool isValidationEnabled;
  late Pointer<VkInstance> vInstance;
  late Pointer<VkDebugUtilsMessengerEXT> vDebugMessenger;
  late int mLayerCount = 0;
  late Pointer<Pointer<Utf8>> pLayers;

  /// Construct the instance.
  /// If [enableValidation] is set to true, it will generate the required
  /// instance extensions and the validation layers along with the debug
  /// messenger. This might be slow and is not recommended when deploying the
  /// application, as its not needed then.
  Instance(bool enableValidation) : isValidationEnabled = enableValidation {
    // Create the application info structure.
    final vApplicationInfo = calloc<VkApplicationInfo>();
    vApplicationInfo.ref
      ..sType = VK_STRUCTURE_TYPE_APPLICATION_INFO
      ..pNext = nullptr
      ..pApplicationName = "Reality Core".toNativeUtf8()
      ..applicationVersion = makeVersion(1, 0, 0)
      ..pEngineName = "Re-Co".toNativeUtf8()
      ..engineVersion = makeVersion(1, 0, 0)
      ..apiVersion = makeVersion(1, 1, 0);

    // Get the required instance extensions.
    //vkEnumerateInstanceExtensionProperties = Pointer<
    //            NativeFunction<
    //                VkEnumerateInstanceExtensionPropertiesNative>>.fromAddress(
    //        vkGetInstanceProcAddr(nullptr,
    //                'vkEnumerateInstanceExtensionProperties'.toNativeUtf8())
    //            .address)
    //    .asFunction<VkEnumerateInstanceExtensionProperties>();

    Pointer<Int32> extensionsCount = calloc<Int32>();
    vkEnumerateInstanceExtensionProperties(nullptr, extensionsCount, nullptr);
    final props = calloc<VkExtensionProperties>(extensionsCount.value);
    vkEnumerateInstanceExtensionProperties(nullptr, extensionsCount, props);

    // Create the new buffer to store the extension names and then iterate over
    // the strings we got. Afterwards we can get and assign the names.
    final Pointer<Pointer<Utf8>> nativeExtensions =
        calloc<Pointer<Utf8>>(extensionsCount.value);
    for (int i = 0; i < extensionsCount.value; i++) {
      nativeExtensions[i] = props.elementAt(i).ref.toString().toNativeUtf8();
    }

    // Create the instance create info structure.
    final vInstanceCreateInfo = calloc<VkInstanceCreateInfo>();
    vInstanceCreateInfo.ref
      ..sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO
      ..pNext = nullptr
      ..flags = 0
      ..pApplicationInfo = vApplicationInfo
      ..enabledExtensionCount = extensionsCount.value
      ..ppEnabledExtensionNames = nativeExtensions;

    // Setup the validation layers if needed.
    if (enableValidation) {
      // These are the validation layers we would need.
      const layers = ["VK_LAYER_KHRONOS_validation"];

      // Get the length and create the layers using the layer strings.
      mLayerCount = layers.length;
      pLayers = calloc<Pointer<Utf8>>(mLayerCount);
      for (int i = 0; i < mLayerCount; i++) {
        pLayers[i] = layers[i].toNativeUtf8();
      }

      // Fill the required data to the create info structure.
      vInstanceCreateInfo.ref
        ..pNext = _createDebugMessengerCreateInfo()
        ..enabledLayerCount = mLayerCount
        ..ppEnabledLayerNames = pLayers;
    }

    // Create the instance.
    final instance = calloc<Pointer<VkInstance>>();
    validateResult(vkCreateInstance(vInstanceCreateInfo, nullptr, instance),
        "Failed to create the Vulkan instance!");

    // Assign the created instance to the instance object.
    vInstance = instance.value;

    // Create the debug messenger if validation is enabled.
    if (enableValidation) {
      vkCreateDebugUtilsMessengerEXT = Pointer<
                  NativeFunction<
                      VkCreateDebugUtilsMessengerEXTNative>>.fromAddress(
              vkGetInstanceProcAddr(
                      nullptr, 'vkCreateDebugUtilsMessengerEXT'.toNativeUtf8())
                  .address)
          .asFunction<VkCreateDebugUtilsMessengerEXT>();

      final vDebugger = calloc<Pointer<VkDebugUtilsMessengerEXT>>();
      validateResult(
          vkCreateDebugUtilsMessengerEXT(
              vInstance, _createDebugMessengerCreateInfo(), nullptr, vDebugger),
          "Failed to create the Vulkan debug messenger!");
    }
  }

  /// Get the Vulkan instance pointer.
  Pointer<VkInstance> getInstance() {
    return vInstance;
  }

  /// Get the debug messenger.
  Pointer<VkDebugUtilsMessengerEXT> getDebugger() {
    return vDebugMessenger;
  }

  /// Get the stored layer count.
  int getLayerCount() {
    return mLayerCount;
  }

  /// Get the layers.
  Pointer<Pointer<Utf8>> getLayers() {
    return pLayers;
  }

  /// Create a new device.
  Device createDevice() {
    return Device(this);
  }

  /// Create a new display with the [extent].
  Display createDisplay(Extent2D extent) {
    return Display(this, extent);
  }

  /// Destroy the instance.
  @override
  void destroy() {
    // Destroy the debug messenger if validation is enabled.
    if (isValidationEnabled) {
      vkDestroyDebugUtilsMessengerEXT = Pointer<
                  NativeFunction<
                      VkDestroyDebugUtilsMessengerEXTNative>>.fromAddress(
              vkGetInstanceProcAddr(
                      nullptr, 'vkDestroyDebugUtilsMessengerEXT'.toNativeUtf8())
                  .address)
          .asFunction<VkDestroyDebugUtilsMessengerEXT>();

      vkDestroyDebugUtilsMessengerEXT(vInstance, vDebugMessenger, nullptr);
    }

    vkDestroyInstance(vInstance, nullptr);
  }

  /// Create the debug messenger create info structure.
  Pointer<VkDebugUtilsMessengerCreateInfoEXT>
      _createDebugMessengerCreateInfo() {
    final vCreteInfo = calloc<VkDebugUtilsMessengerCreateInfoEXT>();

    return vCreteInfo;
  }
}
