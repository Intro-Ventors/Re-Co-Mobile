import 'dart:ffi';

import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart';

import 'camera.dart';

class NativeMatrix extends Struct {
  @Float()
  external double x;
}

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

  late Camera mCamera;

  late Pointer<Void> Function(int, int, Pointer<Uint8>, int)
      _createEngineWithImage;
  late ImageData Function(Pointer<Void>) _getImageData;
  late void Function(Pointer<Void>) _destroyEngine;

  /// Construct the engine using the render target's [width], [height] and the
  /// [baseAssetPath].
  Engine(int width, int height, ByteData bytes) {
    // Try and load the engine library.
    mEngine = Platform.isAndroid
        ? DynamicLibrary.open('libgraphics_engine.so')
        : DynamicLibrary.process();

    _createEngineWithImage = mEngine
        .lookup<
            NativeFunction<
                Pointer<Void> Function(
                    Uint32, Uint32, Pointer<Uint8>, Uint64)>>('createEngine')
        .asFunction();

    _destroyEngine = mEngine
        .lookup<NativeFunction<Void Function(Pointer<Void>)>>('destroyEngine')
        .asFunction();

    _getImageData = mEngine
        .lookup<NativeFunction<ImageData Function(Pointer<Void>)>>(
            'getImageData')
        .asFunction();

    mCamera = Camera(mEngine, pInstance);
    final buffer = calloc<Uint8>(bytes.lengthInBytes);
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      buffer.elementAt(i).value = bytes.getUint8(i);
    }

    pInstance =
        _createEngineWithImage(width, height, buffer, bytes.lengthInBytes);
    calloc.free(buffer);
  }

  /// Get the camera of the engine.
  Camera getCamera() {
    return mCamera;
  }

  /// Get the rendered image from the backend.
  Image getRenderData() {
    final data = _getImageData(pInstance);
    return Image.memory(data.pImageData.asTypedList(
        data.mWidth * data.mHeight * data.mDepth * data.mBitsPerPixel));
  }

  Pointer<Uint8> _toPointer(ByteData bytes) {
    final buffer = calloc<Uint8>(bytes.lengthInBytes);
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      buffer.elementAt(i).value = bytes.getUint8(i);
    }

    return buffer;
  }

  /// Destroy the engine.
  void destroy() {
    _destroyEngine(pInstance);
  }
}
