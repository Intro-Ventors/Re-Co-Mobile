import 'dart:ffi';

import 'dart:io';

import 'package:flutter/widgets.dart';

class ImageData extends Struct {
  external Pointer<Uint8> pImageData;

  @Uint64()
  external int mWidth;
  @Uint64()
  external int mHeight;
  @Uint64()
  external int mDepth;
  @Uint64()
  external int mBitsPerPixel;
}

class ShaderInfo extends Struct {
  external Pointer<Void> pBindings;
  external Pointer<Void> pInputAttributes;
  external Pointer<Void> pOutputAttributes;

  @Uint64()
  external int mBindingCount;
  @Uint64()
  external int mInputAttributeCount;
  @Uint64()
  external int mOutputAttributeCount;
}

class Engine {
  late DynamicLibrary mEngine;
  late Pointer<Void> pInstance;

  late Pointer<Void> Function() _createEngine;
  late ImageData Function(Pointer<Void>) _getImageData;
  late ShaderInfo Function(Pointer<Void>) _getVertexShaderInfo;
  late void Function(Pointer<Void>) _destroyEngine;

  /// Default constructor.
  Engine() {
    // Try and load the engine library.
    mEngine = Platform.isAndroid
        ? DynamicLibrary.open('libgraphics_engine.so')
        : DynamicLibrary.process();

    // Load the functions.
    _createEngine = mEngine
        .lookup<NativeFunction<Pointer<Void> Function()>>('createEngine')
        .asFunction();

    _destroyEngine = mEngine
        .lookup<NativeFunction<Void Function(Pointer<Void>)>>('destroyEngine')
        .asFunction();

    _getImageData = mEngine
        .lookup<NativeFunction<ImageData Function(Pointer<Void>)>>(
            'getImageData')
        .asFunction();

    _getVertexShaderInfo = mEngine
        .lookup<NativeFunction<ShaderInfo Function(Pointer<Void>)>>(
            'getVertexShaderInfo')
        .asFunction();

    // Create the instance.
    pInstance = _createEngine();
  }

  /// Get the rendered image from the backend.
  Image getRenderData() {
    final data = _getImageData(pInstance);
    return Image.memory(data.pImageData.asTypedList(
        data.mWidth * data.mHeight * data.mDepth * data.mBitsPerPixel));
  }

  /// Get the global vertex shader info.
  ShaderInfo getVertexShaderInfo() {
    return _getVertexShaderInfo(pInstance);
  }

  /// Destroy the engine.
  void destroy() {
    _destroyEngine(pInstance);
  }
}
