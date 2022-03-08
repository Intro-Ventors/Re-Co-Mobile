import 'dart:ffi';

import 'dart:io';

class Engine {
  late DynamicLibrary mEngine;
  late Pointer<Void> pInstance;

  late Pointer<Void> Function() _createEngine;
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

    // Create the instance.
    pInstance = _createEngine();
  }

  /// Destroy the engine.
  void destroy() {
    _destroyEngine(pInstance);
  }
}
