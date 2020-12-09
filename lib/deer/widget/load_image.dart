import 'package:flutter/material.dart';
import 'package:flutterapp/deer/util/image_util.dart';

/// @Date：2020/12/8
/// @Author：songdongliang
/// Desc：加载图片

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {

  final String image;
  final double width;
  final double height;
  final int cacheWidth;
  final int cacheHeight;
  final BoxFit fit;
  final ImageFormat format;
  final Color color;

  const LoadAssetImage(this.image, {
    Key key,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.format = ImageFormat.png,
    this.color
  }): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,
      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }

}