import 'package:flutter/material.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/routers/navigator_utils.dart';
import 'package:flutterapp/deer/widget/base_dialog.dart';
import 'package:flutterapp/deer/widget/load_image.dart';

/// @Date：2021/1/4
/// @Author：songdongliang
/// Desc：
class PayTypeDialog extends StatefulWidget {

  final Function(int, String) onPressed;

  const PayTypeDialog({
    Key key,
    this.onPressed
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _PayTypeDialog();

}

class _PayTypeDialog extends State<PayTypeDialog> {

  int _value = 0;
  final _list = ['未收款', '支付宝', '微信', '现金'];

  Widget _buildItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                  child: Text(
                    _list[index],
                    style: _value == index ? TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: Theme.of(context).primaryColor,
                    ) : null,
                  ),
              ),
              Visibility(
                visible: _value == index,
                  child: const LoadAssetImage('order/ic_check', width: 16.0, height: 16.0,)
              ),
              Gaps.hGap16
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '收款方式',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_list.length, (index) => _buildItem(index)),
        ),
      onPressed: () {
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, _list[_value]);
      },
    );
  }

}