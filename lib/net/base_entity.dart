/// @Date：2020/12/4 
/// @Author：songdongliang
/// Desc：
class BaseDataModel<T> {

  String message;
  int code;
  T data;

  BaseDataModel({this.data, this.message, this.code});

  BaseDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'] as T;
  }
}