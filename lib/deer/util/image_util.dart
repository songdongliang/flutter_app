/// @Date：2020/12/8 
/// @Author：songdongliang
/// Desc：

class ImageUtils {

  static String getImgPath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }
}

enum ImageFormat {
  png,
  jpg,
  gif,
  webp
}

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}