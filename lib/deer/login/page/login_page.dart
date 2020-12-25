import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/constant.dart';
import 'package:flutterapp/deer/localization/app_localizations.dart';
import 'package:flutterapp/deer/login/widgets/my_text_field.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/routers/login_router.dart';
import 'package:flutterapp/deer/routers/navigator_utils.dart';
import 'package:flutterapp/deer/util/change_notifier_mixin.dart';
import 'package:flutterapp/deer/util/other_utils.dart';
import 'package:flutterapp/deer/widget/my_app_bar.dart';
import 'package:flutterapp/deer/widget/my_button.dart';
import 'package:flutterapp/deer/widget/my_scroll_view.dart';

/// @Date：2020/12/24
/// @Author：songdongliang
/// Desc：
class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> with ChangeNotifierMixin<LoginPage> {

  // 定义一个controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = SpUtil.getString(Constant.phone);
  }

  void _login() {
    SpUtil.putString(Constant.phone, _nameController.text);
    // TODO 跳转到主页

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: '验证码登录',
        onPressed: () {
          // TODO 跳转到验证码页面

        },
      ),
      body: MyScrollView(
          children: _buildBody,
        keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      ),
    );
  }

  List<Widget> get _buildBody => <Widget>[
    Text("密码登录", style: TextStyles.textBold26,),
    Gaps.vGap16,
    MyTextField(
        controller: _nameController,
      key: const Key('phone'),
      focusNode: _nodeText1,
      maxLength: 11,
      keyboardType: TextInputType.phone,
      hintText: '请输入手机号',
    ),
    Gaps.vGap8,
    MyTextField(
      key: const Key('password'),
        keyName: 'password',
        controller: _passwordController,
      focusNode: _nodeText2,
      isInputPwd: true,
      maxLength: 16,
      hintText: '请输入密码',
    ),
    Gaps.vGap24,
    MyButton(
        onPressed: _clickable ? _login : null,
      key: const Key('login'),
      text: '登录',
    ),
    Container(
      height: 40.0,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          '忘记密码',
          key: const Key('forgotPassword'),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        onTap: () {
          // TODO 忘记密码页面
        },
      ),
    ),
    Gaps.vGap16,
    Container(
      alignment: Alignment.center,
      child: GestureDetector(
        child: Text(
          '还没账号? 快去注册',
          key: const Key('noAccountRegister'),
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
        onTap: () {
          NavigatorUtils.push(context, LoginRouter.registerPage);
        },
      ),
    ),
  ];

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    final List<VoidCallback> callbacks = [_verify];
    return {
      _nameController: callbacks,
      _passwordController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }

    // 状态不一样再刷新，避免重复不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

}