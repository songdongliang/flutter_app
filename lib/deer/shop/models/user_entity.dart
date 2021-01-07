import 'package:flutterapp/deer/generated/json/base/json_convert_content.dart';
import 'package:flutterapp/deer/generated/json/base/json_filed.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
class UserEntity with JsonConvert<UserEntity> {
  @JSONField(name: 'avatar_url')
  String avatarUrl;
  String name;
  int id;
  String blog;
}