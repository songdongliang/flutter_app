import 'package:flutter/material.dart';
import 'package:flutterapp/deer/util/change_notifier_mixin.dart';
import 'package:flutterapp/deer/util/toast.dart';

/// @Date：2020/12/25
/// @Author：songdongliang
/// Desc：
class ResetPasswordPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ResetPasswordPageState();

}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with ChangeNotifierMixin<ResetPasswordPage> {

  // 定义controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _nameController: callbacks,
      _vCodeController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
      _nodeText3: null,
    };
  }

  void _verify() {
    final String name = _nameController.text;
    final String vCode = _vCodeController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _reset() {
    Toast.show("确定");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}