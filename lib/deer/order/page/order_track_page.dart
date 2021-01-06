import 'package:flutter/material.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/widget/my_app_bar.dart';
import 'package:flutterapp/deer/widget/my_scroll_view.dart';
import 'package:flutterapp/demo/widgetDemo.dart';

/// @Date：2021/1/6
/// @Author：songdongliang
/// Desc：
class OrderTrackPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _OrderTrackPageState();

}

class _OrderTrackPageState extends State<OrderTrackPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '订单跟踪',
      ),
      body: MyScrollView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                  top: 21.0, left: 16.0, right: 16.0
                ),
              child: Row(
                children: <Widget>[
                  const Text('订单编号: '),
                  // 可选择文本组件(复制)
                  Semantics(
                    label: '长按复制订单编号',
                    child: const SelectableText('145762666926326', maxLines: 1,),
                  )
                ],
              ),
            ),
            Stepper(
              physics: const BouncingScrollPhysics(),
                currentStep: 3,
                controlsBuilder: (_, {onStepContinue, onStepCancel}) {
                  return Gaps.empty;
                },
                steps: List.generate(4, (index) => _buildStep(index))
            )
          ]
      ),
    );
  }

  final List<String> _titleList = ['订单已完成', '开始配送', '等待配送', '收到新订单'];
  final List<String> _timeList = ['2021/08/30 13:30', '2021/08/30 11:30', '2021/08/30 9:30', '2021/08/30 9:00'];

  Step _buildStep(int index) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Step(
        title: Padding(
            padding: const EdgeInsets.only(top: 15.0),
          child: Text(_titleList[index], style: index == 0 ? TextStyle(
            fontSize: Dimens.font_sp14,
            color: primaryColor
          ) : Theme.of(context).textTheme.bodyText2),
        ),
        subtitle: Text(_timeList[index],
          style: index == 0 ? TextStyle(
            fontSize: Dimens.font_sp12,
            color: primaryColor,
          ) : Theme.of(context).textTheme.subtitle2,
        ),
        content: const Text(''),
      isActive: index == 0,
      // TODO 这里的状态图标无法修改, 暂时使用原生的，应该可以复制step代码修改一下
      state: index == 0 ? StepState.complete : StepState.indexed,
    );
  }

}