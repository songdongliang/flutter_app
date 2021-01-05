import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/deer/order/widgets/pay_type_dialog.dart';
import 'package:flutterapp/deer/res/colors.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/routers/navigator_utils.dart';
import 'package:flutterapp/deer/util/other_utils.dart';
import 'package:flutterapp/deer/util/toast.dart';
import 'package:flutterapp/deer/widget/my_card.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';

/// @Date：2021/1/4
/// @Author：songdongliang
/// Desc：

const List<String> orderLeftButtonText = ['拒单', '拒单', '订单跟踪', '订单跟踪', '订单跟踪',];
const List<String> orderRightButtonText = ['接单', '开始配送', '完成', '', ''];

class OrderItem extends StatelessWidget {

  final int tabIndex;
  final int index;

  const OrderItem({
    Key key,
    @required this.tabIndex,
    @required this.index
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
      child: MyCard(
          child: Padding(
              padding: EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                // TODO 跳转到订单详情
              } ,
            ),
          )
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText2.copyWith(fontSize: Dimens.font_sp12);
    final bool isDark = context.isDark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(child: Text('150000000(郭力)')),
            Text('货到付款',
              style: TextStyle(
                  fontSize: Dimens.font_sp12,
                color: Theme.of(context).errorColor
              ),
            )
          ],
        ),
        Gaps.vGap8,
        Text('西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        RichText(
            text: TextSpan(
              style: textStyle,
              children: <TextSpan>[
                const TextSpan(text: '清凉一度抽纸'),
                TextSpan(text: ' x1', style: Theme.of(context).textTheme.subtitle2),
              ],
            ),
        ),
        Gaps.vGap8,
        RichText(
            text: TextSpan(
              style: textStyle,
              children: <TextSpan>[
                const TextSpan(text: '清凉一度抽纸'),
                TextSpan(text: '', style: Theme.of(context).textTheme.subtitle2)
              ],
            )
        ),
        Gaps.vGap12,
        Row(
          children: <Widget>[
            Expanded(
                child: RichText(
                    text: TextSpan(
                      style: textStyle,
                      children: <TextSpan>[
                        TextSpan(text: Utils.formatPrice('20.00', format: MoneyFormat.NORMAL)),
                        TextSpan(text: '  共3件商品', style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp10))
                      ],
                    )
                )
            ),
            const Text('2018.02.05 10：00', style: TextStyles.textSize12,)
          ],
        ),
        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        Row(
          children: <Widget>[
            OrderItemButton(
              key: Key('order_button_1_$index'),
              text: '联系客户',
              textColor: isDark ? SColors.dark_text : SColors.text,
              bgColor: isDark ? SColors.dark_material_bg : SColors.bg_gray,
              onTap: () => _showCallPhoneDialog(context, '15012349876'),
            ),
            const Expanded(child: Gaps.empty),
            OrderItemButton(
              key: Key('order_button_2_$index'),
              text: orderLeftButtonText[tabIndex],
              textColor: isDark ? SColors.dark_text : SColors.text,
              bgColor: isDark ? SColors.dark_material_bg : SColors.bg_gray,
              onTap: () {
                if (tabIndex >= 2) {
                  // TODO 跳转到track页面
                }
              },
            ),
            if (orderRightButtonText[tabIndex].isEmpty) Gaps.empty else Gaps.hGap10,
            if (orderRightButtonText[tabIndex].isEmpty) Gaps.empty else OrderItemButton(
              key: Key('order_button_3_$index'),
              text: orderRightButtonText[tabIndex],
              textColor: isDark ? SColors.dark_button_text : Colors.white,
              bgColor: isDark ? SColors.dark_app_main : SColors.app_main,
              onTap: () {
                if (tabIndex == 2) {
                  _showPayTypeDialog(context);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showPayTypeDialog(BuildContext context) {
    showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return PayTypeDialog(
            onPressed: (index, type) {
              Toast.show('收款类型: $type');
            },
          );
      }
    );
  }

  void _showCallPhoneDialog(BuildContext context, String phone) {
    showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text('是否拨打: $phone ?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () => NavigatorUtils.goBack(context),
                  child: const Text('取消')
              ),
              TextButton(
                  onPressed: () {
                    Utils.launchTelURL(phone);
                    NavigatorUtils.goBack(context);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(Theme.of(context).errorColor.withOpacity(0.2))
                  ),
                  child: Text('拨打', style: TextStyle(color: Theme.of(context).errorColor),)
              )
            ],
          );
      }
    );
  }

}

class OrderItemButton extends StatelessWidget {

  final Color bgColor;
  final Color textColor;
  final GestureTapCallback onTap;
  final String text;

  const OrderItemButton({
    Key key,
    this.bgColor,
    this.textColor,
    this.text,
    this.onTap
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0)
        ),
        constraints: const BoxConstraints(
          minWidth: 64.0,
          maxHeight: 30.0,
          minHeight: 30.0
        ),
        child: Text(text, style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),),
      ),
      onTap: onTap,
    );
  }
}