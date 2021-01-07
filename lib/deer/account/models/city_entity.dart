import 'package:azlistview/azlistview.dart';
import 'package:flutterapp/deer/generated/json/base/json_convert_content.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
class CityEntity with JsonConvert<CityEntity>, ISuspensionBean {
  String name;
  String cityCode;
  String firstCharacter;

  @override
  String getSuspensionTag() {
    return firstCharacter;
  }
}