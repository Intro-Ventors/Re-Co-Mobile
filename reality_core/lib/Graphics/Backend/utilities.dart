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
