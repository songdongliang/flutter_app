import 'package:flutter/material.dart';
import 'package:flutterapp/deer/login/widgets/my_text_field.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/util/change_notifier_mixin.dart';
import 'package:flutterapp/deer/util/other_utils.dart';
import 'package:flutterapp/deer/util/toast.dart';
import 'package:flutterapp/deer/widget/my_app_bar.dart';
import 'package:flutterapp/deer/widget/my_button.dart';
import 'package:flutterapp/deer/widget/my_scroll_view.dart';

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
    return Scaffold(
      appBar: MyAppBar(
        title: '忘记密码',
      ),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2, _nodeText3]),
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Text('获取验证码', style: TextStyles.textBold26,),
      Gaps.vGap16,
      MyTextField(
          controller: _nameController,
        focusNode: _nodeText1,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: '请输入账号',
      ),
      Gaps.vGap8,
      MyTextField(
          controller: _vCodeController,
        focusNode: _nodeText2,
        keyboardType: TextInputType.number,
        getVCode: () {
            return Future.value(true);
        },
        maxLength: 6,
        hintText: '请输入验证码',
      ),
      Gaps.vGap8,
      MyTextField(
          controller: _passwordController,
        focusNode: _nodeText3,
        isInputPwd: true,
        maxLength: 16,
        keyboardType: TextInputType.visiblePassword,
        hintText: '请输入密码',
      ),
      Gaps.vGap24,
      MyButton(
          onPressed: _clickable ? _reset : null,
        text: '确定',
      ),
    ];
  }

}