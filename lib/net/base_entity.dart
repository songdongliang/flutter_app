import 'package:flutterapp/common/constant.dart';
import 'package:flutterapp/deer/generated/json/base/json_convert_content.dart';

/// @Date：2020/12/4
/// @Author：songdongliang
/// Desc：
class BaseDataModel<T> {

  BaseDataModel(this.code, this.message, this.data);

  BaseDataModel.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code] as int;
    message = json[Constant.message] as String;
    if (json.containsKey(Constant.data)) {
      data = _generateOBJ<T>(json[Constant.data]);
    }
  }

  int code;
  String message;
  T data;

  T _generateOBJ<T>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}