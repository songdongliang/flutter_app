import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/deer/res/colors.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';
import 'package:flutterapp/deer/widget/load_image.dart';

/// @Date：2021/1/8
/// @Author：songdongliang
/// Desc：
class SearchBar extends StatefulWidget implements PreferredSizeWidget {

  final String backImg;
  final String hintText;
  final Function(String) onPressed;

  const SearchBar({
    Key key,
    this.hintText = '',
    this.backImg = 'assets/images/ic_back_black.png',
    this.onPressed
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(48.0);

}

class _SearchBarState extends State<SearchBar> {

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color iconColor = isDark ? SColors.dark_text_gray : SColors.text_gray_c;

    final Widget back = Semantics(
      label: '返回',
      child: SizedBox(
        width: 48.0,
        height: 48.0,
        child: InkWell(
          onTap: () {
            _focus.unfocus();
            Navigator.maybePop(context);
          },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
            key: const Key('search_back'),
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              widget.backImg,
              color: isDark ? SColors.dark_text : SColors.text,
            ),
          ),
        ),
      ),
    );

    final Widget textField = Expanded(
        child: Container(
          height: 32.0,
          decoration: BoxDecoration(
            color: isDark ? SColors.dark_material_bg : SColors.bg_gray,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextField(
            key: const Key('search_text_field'),
            controller: _controller,
            focusNode: _focus,
            maxLines: 1,
            textInputAction: TextInputAction.search,
            onSubmitted: (val) {
              _focus.unfocus();
              // 点击软键盘的动作按钮时的回调
              widget.onPressed(val);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: -8.0, right: -16.0, bottom: 14.0),
              border: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                child: LoadAssetImage('order/order_search', color: iconColor,),
              ),
              hintText: widget.hintText,
              suffixIcon: GestureDetector(
                child: Semantics(
                  label: '清空',
                  child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                    child: LoadAssetImage('order/order_delete', color: iconColor,),
                  ),
                ),
                onTap: () {
                  // https://github.com/flutter/flutter/issues/35848
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    _controller.text = '';
                  });
                },
              )
            ),
          ),
        )
    );

    final Widget search = Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: ButtonThemeData(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 32.0,
            minWidth: 44.0,
            // 距顶部为0
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0)
            )
          ),
        ),
        child: FlatButton(
          textColor: isDark ? SColors.dark_button_text : Colors.white,
            color: isDark ? SColors.dark_app_main : SColors.app_main,
            onPressed: () {
              _focus.unfocus();
              widget.onPressed(_controller.text);
            },
            child: const Text(
              '搜索',
              style: TextStyle(
                fontSize: Dimens.font_sp14
              ),
            )
        )
    );

    return AnnotatedRegion(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Material(
        color: context.backgroundColor,
        child: SafeArea(
            child: Container(
              child: Row(
                children: <Widget>[
                  back,
                  textField,
                  Gaps.hGap8,
                  search,
                  Gaps.hGap16
                ],
              ),
            )
        ),
      ),
    );
  }

}