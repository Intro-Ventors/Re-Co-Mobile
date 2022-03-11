import 'dart:ffi';

import 'dart:io';

import 'package:ffi/ffi.dart';
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

class Engine {
  late DynamicLibrary mEngine;
  late Pointer<Void> pInstance;

  late Pointer<Void> Function(int, int, Pointer<Utf8>) _createEngine;
  late ImageData Function(Pointer<Void>) _getImageData;
  late void Function(Pointer<Void>) _destroyEngine;

  /// Construct the engine using the render target's [width], [height] and the
  /// [baseAssetPath].
  Engine(int width, int height, String baseAssetPath) {
    // Try and load the engine library.
    mEngine = Platform.isAndroid
        ? DynamicLibrary.open('libgraphics_engine.so')
        : DynamicLibrary.process();

    // Load the functions.
    _createEngine = mEngine
        .lookup<
            NativeFunction<
                Pointer<Void> Function(
                    Uint32, Uint32, Pointer<Utf8>)>>('createEngine')
        .asFunction();

    _destroyEngine = mEngine
        .lookup<NativeFunction<Void Function(Pointer<Void>)>>('destroyEngine')
        .asFunction();

    _getImageData = mEngine
        .lookup<NativeFunction<ImageData Function(Pointer<Void>)>>(
            'getImageData')
        .asFunction();

    // Create the instance.
    pInstance = _createEngine(width, height, baseAssetPath.toNativeUtf8());
  }

  /// Get the rendered image from the backend.
  Image getRenderData() {
    final data = _getImageData(pInstance);
    return Image.memory(data.pImageData.asTypedList(
        data.mWidth * data.mHeight * data.mDepth * data.mBitsPerPixel));
  }

  /// Destroy the engine.
  void destroy() {
    _destroyEngine(pInstance);
  }
}
