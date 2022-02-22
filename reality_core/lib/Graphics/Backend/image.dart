import 'buffer.dart';
import 'device.dart';
import 'deviceBoundObject.dart';
import 'utilities.dart';

class Image extends DeviceBoundObject {
  final Extent3D mExtent;
  var mImageType;
  final int mLayers;
  final int mMipLevel;

  /// Construct the image using the parent [device], [extent], [imageType], [layers] and [mipLevel].
  Image(Device device, Extent3D extent, var imageType, int layers, int mipLevel)
      : mExtent = extent,
        mImageType = imageType,
        mLayers = layers,
        mMipLevel = mipLevel,
        super(device, null) {}

  void getImage() {}

  void getImageView() {}
  void getImageSampler() {}
  void copyFromStagingBugger(Buffer buffer) {}

  @override
  void destroy() {}
}
