import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 监听键盘
class KeyboardDemoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _KeyboardDemoPageState();

}

class _KeyboardDemoPageState extends State<KeyboardDemoPage> {

  bool isKeyboardShowing = false;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDetector(
      showCallback: (show) {
        setState(() {
          isKeyboardShowing = show;
        });
      },
      content: Scaffold(
        appBar: AppBar(
          title: Text("KeyboardDemoPage"),
        ),
        body: GestureDetector(
          // 透明可以触摸
          behavior: HitTestBehavior.translucent,
          onTap: (){
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
              child: Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text("测试，测试，测试，测试，测试，测试，测试，测试，测试，测试，测试，测试，测试，测试，测试"),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent)
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "请输入",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 0)
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 0)
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 0)
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 0)
                                  )
                                ),
                                controller: textEditingController,
                              ),
                            ),
                            Visibility(
                              visible: isKeyboardShowing,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text("bottom bar"),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                color: Colors.grey,
                              )
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

}


typedef KeyboardShowCallback = void Function(bool isKeyboardShowing);

/// 监听键盘收起
class KeyboardDetector extends StatefulWidget {

  final KeyboardShowCallback showCallback;

  final Widget content;

  KeyboardDetector({this.showCallback, this.content});

  @override
  State<StatefulWidget> createState() => _KeyboardDetectorState();

}

class _KeyboardDetectorState extends State<KeyboardDetector>
    with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        setState(() {
          widget.showCallback?.call(MediaQuery.of(context).viewInsets.bottom > 0);
        });
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.content;
  }

}