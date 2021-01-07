import 'package:azlistview/azlistview.dart';
import 'package:flutterapp/deer/generated/json/base/json_convert_content.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
class BankEntity with JsonConvert<BankEntity>, ISuspensionBean {

  BankEntity({this.id, this.bankName, this.firstLetter});

  int id;
  String bankName;
  String firstLetter;

  @override
  String getSuspensionTag() {
    return firstLetter;
  }
}