import 'package:flutter/material.dart';
import 'package:flutterapp/deer/localization/app_localizations.dart';
import 'package:flutterapp/deer/login/widgets/my_text_field.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/util/change_notifier_mixin.dart';
import 'package:flutterapp/deer/util/other_utils.dart';
import 'package:flutterapp/deer/util/toast.dart';
import 'package:flutterapp/deer/widget/my_app_bar.dart';
import 'package:flutterapp/deer/widget/my_button.dart';
import 'package:flutterapp/deer/widget/my_scroll_view.dart';

/// @Date：2020/12/5
/// @Author：songdongliang
/// Desc：
class RegisterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> with ChangeNotifierMixin<RegisterPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _clickable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "注册",
      ),
      body: MyScrollView(
        // keyboardConfig: Utils.getKeyboardActionsConfig(context,
        //     <FocusNode>[_nodeText1, _nodeText2, _nodeText3]),
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Text("开启你的账号", style: TextStyles.textBold26,),
      Gaps.vGap16,
      MyTextField(
        key: const Key('phone'),
        focusNode: _nodeText1,
        controller: _nameController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: '请输入手机号',
        isInputPwd: false,
          autoFocus: false,
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('vcode'),
        focusNode: _nodeText2,
        controller: _vCodeController,
        keyboardType: TextInputType.number,
        getVCode: () async {
          if (_nameController.text.length == 11) {
            Toast.show("并没有真正发送，直接登录吧");
            /// 一般可以在发送真正的请求，请求成功返回true
            return true;
          } else {
            Toast.show("请输入有效的手机号");
            return false;
          }
        },
        maxLength: 6,
        hintText: '请输入验证码',
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('password'),
        keyName: 'password',
        focusNode: _nodeText3,
        isInputPwd: true,
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        maxLength: 16,
        hintText: '请输入密码',
      ),
      Gaps.vGap24,
      MyButton(
        key: const Key('register'),
        onPressed: _clickable ? _register : null,
        text: '注册',
      )
    ];
  }

  void _register() {
    Toast.show('点击注册');
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _nameController: callbacks,
      _vCodeController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
      _nodeText3: null
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
    if (_clickable != clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

}