import 'package:vulkan/vulkan.dart';

class Extent2D {
  int mWidth = 0;
  int mHeight = 0;

  /// Default constructor.
  constructor() {}

  /// Set the width as [width] and return `this`.
  Extent2D setWidth(int width) {
    mWidth = width;
    return this;
  }

  /// Set the height as [height] and return `this`.
  Extent2D setHeight(int height) {
    mHeight = height;
    return this;
  }
}

class Extent3D {
  int mWidth = 0;
  int mHeight = 0;
  int mDepth = 0;

  /// Default constructor.
  constructor() {}

  /// Set the width as [width] and return `this`.
  Extent3D setWidth(int width) {
    mWidth = width;
    return this;
  }

  /// Set the height as [height] and return `this`.
  Extent3D setHeight(int height) {
    mHeight = height;
    return this;
  }

  /// Set the height as [depth] and return `this`.
  Extent3D setDepth(int depth) {
    mDepth = depth;
    return this;
  }
}

/// Make a version integer out of the [major], [minor] and [patch] versions.
int makeVersion(int major, int minor, int patch) =>
    ((major) << 22) | ((minor) << 12) | (patch);

/// Validate a Vulkan [result]. This will print out a [message] if the result is not equal to `VK_SUCCESS`.
void validateResult(final int result, String message) {
  if (result != VK_SUCCESS) print(message);
}
