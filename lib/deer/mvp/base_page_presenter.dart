import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapp/deer/mvp/base_presenter.dart';
import 'package:flutterapp/deer/mvp/mvps.dart';
import 'package:flutterapp/deer/net/http_api.dart';
import 'package:flutterapp/net/dio_util.dart';
import 'package:flutterapp/net/error_handle.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {

  CancelToken _cancelToken;

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void dispose() {
    // 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  /// 返回Future适用于刷新，加载更多
  Future requestNetwork<T>(Method method, {
    @required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T> onSuccess,
    NetErrorCallback onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    if (isShow) {
      view.showProgress();
    }
    return DioUtils.instance.requestNetwork<T>(method, url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        if (isClose) {
          view.closeProgress();
        }
        if (onSuccess != null) {
          onSuccess(data);
        }
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      }
    );
  }

  /// 上传图片实现
  Future<String> uploadImg(File image) async {
    String imgPath = '';
    try {
      final String path = image.path;
      final String name = path.substring(path.lastIndexOf('/') + 1);
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'uploadIcon': await MultipartFile.fromFile(path, filename: name)
      });
      await requestNetwork(Method.post,
          url: HttpApi.upload,
          params: formData,
          onSuccess: (data) {
            imgPath = data;
          });
    } catch (e) {
      view.showToast('图片上传失败! ');
    }
    return imgPath;
  }

  void asyncRequestNetwork<T>(Method method, {
    @required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T> onSuccess,
    NetErrorCallback onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) {
    if (isShow) {
      view.showProgress();
    }
    DioUtils.instance.asyncRequestNetwork<T>(method, url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken?? _cancelToken,
      onSuccess: (data) {
        if (isClose) {
          view.closeProgress();
        }
        if (onSuccess != null) {
          onSuccess(data);
        }
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      },
    );
  }

  void _onError(int code, String msg, NetErrorCallback onError) {
    /// 异常时直接关闭加载圈，不受isClose影响
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }
    /// 页面如果dispose，则不回调onError
    if (onError != null && view.getContext() != null) {
      onError(code, msg);
    }
  }

}