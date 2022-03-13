import 'dart:math';

import 'package:vector_math/vector_math.dart';

class EyeMatrix {
  Matrix4 mViewMatrix = Matrix4.identity();
  Matrix4 mProjectionMatrix = Matrix4.identity();
}

class Camera {
  EyeMatrix mLeftEye;
  EyeMatrix mRightEye;

  late Vector3 mPosition;
  late Vector3 mFront = Vector3(0.0, 0.0, -1.0);
  late Vector3 mRight = Vector3(1.0, 0.0, 0.0);
  late Vector3 mUp = Vector3(0.0, 1.0, 0.0);
  late Vector3 mWorldUp = Vector3(0.0, 1.0, 0.0);

  late double mEyeSeparation = 0.008;
  late double mFieldOfView = 90.0;
  late double mAspectRatio = 0;
  late double mFarPlane = 256.0;
  late double mNearPlane = 0.001;
  late double mYaw = 90.0;
  late double mPitch = 0;
  late double mFocalLength = 0.5;

  Camera(Vector3 position, double aspectRatio)
      : mLeftEye = EyeMatrix(),
        mRightEye = EyeMatrix(),
        mPosition = position,
        mAspectRatio = aspectRatio;

  void update() {
    var wd2 = mNearPlane * tan(radians(mFieldOfView / 2.0));
    var ndfl = mNearPlane / mFocalLength;
    var left, right;
    var top = wd2;
    var bottom = -wd2;

    var front = Vector3.zero();
    front.x = cos(radians(mYaw)) * cos(radians(mPitch));
    front.y = sin(radians(mPitch));
    front.z = sin(radians(mYaw)) * cos(radians(mPitch));
    mFront = front.normalized(); // normalize
    mRight = mFront.cross(mWorldUp);
    mUp = mRight.cross(mFront).normalized(); // normalize

    // Left eye
    left = -mAspectRatio * wd2 + 0.5 * mEyeSeparation * ndfl;
    right = mAspectRatio * wd2 + 0.5 * mEyeSeparation * ndfl;

    setFrustumMatrix(mLeftEye.mProjectionMatrix, left, right, bottom, top,
        mNearPlane, mFarPlane);
    mLeftEye.mViewMatrix =
        Matrix4.translation(mPosition - mRight * (mEyeSeparation / 2.0));

    // Right eye
    left = -mAspectRatio * wd2 - 0.5 * mEyeSeparation * ndfl;
    right = mAspectRatio * wd2 - 0.5 * mEyeSeparation * ndfl;

    setFrustumMatrix(mRightEye.mProjectionMatrix, left, right, bottom, top,
        mNearPlane, mFarPlane);
    mRightEye.mViewMatrix =
        Matrix4.translation(mPosition + mRight * (mEyeSeparation / 2.0));
  }
}
