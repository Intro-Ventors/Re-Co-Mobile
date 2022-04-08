import 'dart:ffi';

class Camera {
  late void Function(Pointer<Void>, int) _moveForward;
  late void Function(Pointer<Void>, int) _moveBackward;
  late void Function(Pointer<Void>, int) _moveLeft;
  late void Function(Pointer<Void>, int) _moveRight;
  late void Function(Pointer<Void>, int) _moveUp;
  late void Function(Pointer<Void>, int) _moveDown;
  late void Function(Pointer<Void>, int) _rotateLeft;
  late void Function(Pointer<Void>, int) _rotateRight;
  late void Function(Pointer<Void>, int) _rotateUp;
  late void Function(Pointer<Void>, int) _rotateDown;
  final Pointer<Void> pInstance;

  /// Construct the camera using an [engine] and an [instance].
  Camera(DynamicLibrary engine, Pointer<Void> instance) : pInstance = instance {
    _moveForward = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'moveCameraForward')
        .asFunction();

    _moveBackward = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'moveCameraBackward')
        .asFunction();

    _moveLeft = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'moveCameraLeft')
        .asFunction();

    _moveRight = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'moveCameraRight')
        .asFunction();

    _moveUp = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'moveCameraUp')
        .asFunction();

    _moveDown = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'moveCameraDown')
        .asFunction();

    _rotateLeft = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'rotateCameraLeft')
        .asFunction();

    _rotateRight = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'rotateCameraRight')
        .asFunction();

    _rotateUp = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'rotateCameraUp')
        .asFunction();

    _rotateDown = engine
        .lookup<NativeFunction<Void Function(Pointer<Void>, Uint64)>>(
            'rotateCameraDown')
        .asFunction();
  }

  /// Move the camera forward.
  void moveForward(int delta) {
    _moveForward(pInstance, delta);
  }

  /// Move the camera backward.
  void moveBackward(int delta) {
    _moveBackward(pInstance, delta);
  }

  /// Move the camera to the left.
  void moveLeft(int delta) {
    _moveLeft(pInstance, delta);
  }

  /// Move the camera to the right.
  void moveRight(int delta) {
    _moveRight(pInstance, delta);
  }

  /// Move the camera up.
  void moveUp(int delta) {
    _moveUp(pInstance, delta);
  }

  /// Move the camera down.
  void moveDown(int delta) {
    _moveDown(pInstance, delta);
  }

  /// Rotate the camera to the left.
  void rotateLeft(int delta) {
    _rotateLeft(pInstance, delta);
  }

  /// Rotate the camera to the right.
  void rotateRight(int delta) {
    _rotateRight(pInstance, delta);
  }

  /// Rotate the camera up.
  void rotateUp(int delta) {
    _rotateUp(pInstance, delta);
  }

  /// Rotate the camera down.
  void rotateDown(int delta) {
    _rotateDown(pInstance, delta);
  }
}
