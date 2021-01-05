import 'package:flutter/material.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/widget/load_image.dart';
import 'package:flutterapp/deer/widget/my_card.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';

/// @Date：2021/1/4
/// @Author：songdongliang
/// Desc：
class OrderTagItem extends StatelessWidget {

  final String date;
  final int orderTotal;

  const OrderTagItem({
    Key key,
    @required this.date,
    @required this.orderTotal
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
      child: MyCard(
          child: Container(
            height: 34.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                if (context.isDark)
                  const LoadAssetImage('order/icon_calendar_dark', width: 14.0, height: 14.0,)
                else
                  const LoadAssetImage('order/icon_calendar', width: 14.0, height:  14.0,),
                Gaps.hGap10,
                Text(date),
                const Expanded(child: Gaps.empty),
                Text('$orderTotal单')
              ],
            ),
          )
      ),
    );
  }

}