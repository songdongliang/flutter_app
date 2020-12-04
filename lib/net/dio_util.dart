import 'package:dio/dio.dart';
import 'package:flutterapp/net/base_entity.dart';

import 'error_handle.dart';

/// @Date：2020/12/3
/// @Author：songdongliang
/// Desc：dio工具类

/// 默认dio配置
int _connectTimeout = 15000;
int _receiveTimeout = 15000;
int _sendTimeout = 10000;
String _baseUrl;
List<Interceptor> _interceptors = [];

/// 初始化Dio配置
void setInitDio({
  int connectTimeout,
  int receiveTimeout,
  int sendTimeout,
  String baseUrl,
  List<Interceptor> interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

typedef NetSuccessCallback<T> = Function(T data);
typedef NetSuccessListCallback<T> = Function(List<T> data);
typedef NetErrorCallback = Function(int code, String msg);

class DioUtils {

  factory DioUtils() => _singleton;

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static Dio _dio;

  static get dio => _dio;

  DioUtils._() {
    final BaseOptions _options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      /// dio默认json解析, 这里指定返回UTF8字符串，自己处理解析(也可以自定义Transformer实现)
      responseType: ResponseType.plain,
      validateStatus: (_) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理(适用于标准REST风格)
        return true;
      },
      baseUrl: _baseUrl,
      // 适用于post form表单提交
      // contentType: Headers.formUrlEncodedContentType,
    );
    _dio = Dio(_options);
    /// 添加拦截器
    _interceptors.forEach((element) {
      _dio.interceptors.add(element);
    });
  }

  // 数据返回格式统一, 统一处理异常
  Future<BaseDataModel<T>> _request<T>(String method, String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    final Response<String> response = await _dio.request<String>(
        url,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options),
      cancelToken: cancelToken
    );
    try {
      final String data = response.data.toString();

    } catch (e) {
      return BaseDataModel<T>(data: null, message: "数据解析错误！", code: ExceptionHandle.parse_error);
    }
    return null;
  }

  Options _checkOptions(String method, Options options) {
    options ??= Options();
    options.method = method;
    return options;
  }

}