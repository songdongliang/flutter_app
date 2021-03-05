import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// @Date：2021/1/12
/// @Author：songdongliang
/// Desc：

const Duration _kWindowDuration = Duration(milliseconds: 300);
const double _kWindowCloseIntervalEnd = 2.0/3.0;
const double _kWindowMaxWidth = 240.0;
const double _kWindowMinWidth = 48.0;
const double _kWindowVerticalPadding = 0.0;
const double _kWindowScreenPadding = 0.0;

Future<T> showPopupWindow<T>({
  @required BuildContext context,
  RelativeRect position,
  @required Widget child,
  double elevation = 8.0,
  String semanticLabel,
  bool fullWidth,
  bool isShowBg = false,
}) {
  assert(context != null);
  String label = semanticLabel;
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      label = semanticLabel;
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      label = semanticLabel ?? MaterialLocalizations.of(context).popupMenuLabel;
      break;
  }

  return Navigator.push(context, _PopupWindowRoute(()));
}

/// 自定义弹窗路由：参照_PopupMenuRoute修改的
class _PopupWindowRoute<T> extends PopupRoute<T> {

  final Widget child;
  final RelativeRect position;
  double elevation;
  final ThemeData theme;
  final String semanticLabel;
  final bool fullWidth;
  final bool isShowBg;
  @override
  final String barrierLabel;


  _PopupWindowRoute({
    RouteSettings settings,
    this.child,
    this.position,
    this.elevation = 8.0,
    this.theme,
    this.barrierLabel,
    this.semanticLabel,
    this.fullWidth,
    this.isShowBg,
  }): super(settings: settings);

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd)
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // Widget win = ;
  }

  @override
  Duration get transitionDuration => _kWindowDuration;

}

class _PopupWindow<T> extends StatelessWidget {

  final _PopupWindowRoute<T> route;
  final String semanticLabel;
  final bool fullWidth;

  const _PopupWindow({
    Key key,
    this.route,
    this.semanticLabel,
    this.fullWidth = false
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    const double length = 10.0;
    // 1.0 for the width and 0.5 for the last item's
    const double unit = 1.0/(length + 1.5);

    final CurveTween opacity = CurveTween(curve: const Interval(0.0, 1.0/3.0));
    final CurveTween width = CurveTween(curve: const Interval(0.0, unit));
    final CurveTween height = CurveTween(curve: const Interval(0.0, unit * length));

    final Widget child = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: fullWidth ? double.infinity : _kWindowMinWidth,
          maxWidth: fullWidth ? double.infinity : _kWindowMaxWidth
        ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: _kWindowVerticalPadding),
        child: route.child,
      ),
    );

    return AnimatedBuilder(
        animation: route.animation,
        builder: (BuildContext context, Widget child) {
          return Opacity(

          );
        }
    );

  }

}