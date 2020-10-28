import 'package:flutter/material.dart';

class SimpleImage extends StatefulWidget {

  final ImageProvider imageProvider;

  const SimpleImage({
    Key key,
    @required this.imageProvider,
  }): assert(imageProvider != null), super(key: key);

  @override
  State<StatefulWidget> createState() => _SimpleImageState();

}

class _SimpleImageState extends State<SimpleImage> {

  ImageStream imageStream;
  ImageInfo imageInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 依赖改变时，图片的配置信息可能会改变
    getImage();
  }

  @override
  void didUpdateWidget(SimpleImage oldWidget) {
    super.didUpdateWidget(oldWidget);

  }

  void getImage() {
    final ImageStream oldImageStream = imageStream;

    // 调用imageProvider的resolve方法，获得ImageStream
    // ignore: invalid_use_of_protected_member
    imageStream = widget.imageProvider
        .createStream(createLocalImageConfiguration(context));
    // 判断新旧imageStream是否相同，如果不同，则需要调整流的监听器
    if (imageStream.key != oldImageStream?.key) {
      final ImageStreamListener listener = ImageStreamListener(updateImage);
      oldImageStream?.removeListener(listener);
      imageStream.addListener(listener);
    }

  }

  void updateImage(ImageInfo imageInfo, bool synchronousCall) {
    setState(() {
      this.imageInfo = imageInfo;
    });
  }

  @override
  void dispose() {
    imageStream.removeListener(ImageStreamListener(updateImage));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawImage(
      image: imageInfo?.image,
      scale: imageInfo?.scale ?? 1.0,
      width: 200,
      height: 200,
    );
  }

}