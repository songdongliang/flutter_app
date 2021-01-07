import 'package:flutter/material.dart';
import 'package:flutterapp/deer/mvp/base_presenter.dart';
import 'package:flutterapp/deer/mvp/mvps.dart';
import 'package:flutterapp/deer/routers/navigator_utils.dart';
import 'package:flutterapp/deer/util/toast.dart';
import 'package:flutterapp/deer/widget/progress_dialog.dart';
import 'package:flutterapp/utils/log.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
mixin BasePageMixin<T extends StatefulWidget, P extends BasePresenter> on State<T> implements IMvpView {

  P presenter;

  P createPresenter();

  bool _isShowDialog = false;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
    }
  }

  @override
  void showProgress() {
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog(
            context: context,
          barrierDismissible: false,
          // 默认dialog背景色为半透明黑色，这里修改为透明(1.20添加属性)
          barrierColor: const Color(0x00FFFFFF),
          builder: (_) {
              return WillPopScope(
                  child: buildProgress(),
                  onWillPop: () async {
                    // 拦截到返回键，即dialog要被手动关闭
                    _isShowDialog = false;
                    return Future.value(true);
                  }
              );
          }
        );
      } catch (e) {
        /// 异常原因主要是页面没有build完成就调用Progress
        print(e);
      }
    }
  }

  @override
  void showToast(String message) {
    Toast.show(message);
  }

  Widget buildProgress() => const ProgressDialog(hintText: '正在加载...',);

  @override
  void didChangeDependencies() {
    presenter?.didChangeDependencies();
    Log.d('$T ==> didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    presenter?.dispose();
    Log.d('$T ===> dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    presenter?.deactivate();
    Log.d('$T ==> deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    presenter?.didUpdateWidgets<T>(oldWidget);
    Log.d('$T ==> didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    Log.d('$T ==> initState');
    presenter = createPresenter();
    presenter?.view = this;
    presenter?.initState();
    super.initState();
  }

}