import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/demo/bubble/bubble_painter.dart';
import 'package:flutterapp/demo/bubble/bubble_widget.dart';

class BubbleDemoPage extends StatelessWidget {

  final double bubbleHeight = 60;
  final double bubbleWidth = 120;

  final GlobalKey contentKey = GlobalKey();

  final GlobalKey button1Key = GlobalKey();
  final GlobalKey button2Key = GlobalKey();
  final GlobalKey button3Key = GlobalKey();
  final GlobalKey button4Key = GlobalKey();

  double getX(GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset.zero).dx;
  }

  double getY(GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset.zero).dy;
  }

  double getWidth(GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    return renderBox.size.width;
  }

  double getHeight(GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  bool isClient() {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (e) {
      return false;
    }
  }

  double getY1() {
    if (isClient()) {
      return getY(button1Key) + getHeight(button1Key)
          - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button1Key) + getHeight(button1Key);
    }
  }

  double getY2() {
    if (isClient()) {
      return getY(button2Key) + getHeight(button2Key) / 2
          - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button2Key) + getHeight(button2Key) / 2;
    }
  }

  double getY3() {
    if (isClient()) {
      return getY(button3Key) - bubbleHeight
          - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button3Key) - bubbleHeight;
    }
  }

  double getY4() {
    if (isClient()) {
      return getY(button4Key) + getHeight(button4Key) / 2
          - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    } else {
      return getY(button4Key) + getHeight(button4Key) / 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bubble Demo Page"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(16),
        child: Stack(
          children: <Widget>[
            MaterialButton(
              key: button1Key,
              color: Colors.blue,
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return BubbleDialog(
                        text: "Text1",
                        height: bubbleHeight,
                        width: bubbleWidth,
                        arrowLocation: ArrowLocation.TOP,
                        x: getX(button1Key) + getWidth(button1Key) / 2,
                        y: getY1()
                      );
                    });
              }),
            Positioned(
              child: MaterialButton(
                key: button2Key,
                color: Colors.greenAccent,
                onPressed: (){
                  showDialog(
                      context: context,
                    builder: (context) {
                        return BubbleDialog(
                          text: "Text2",
                          height: bubbleHeight,
                          width: bubbleWidth,
                          arrowLocation: ArrowLocation.RIGHT,
                          x: getX(button2Key) - bubbleWidth,
                          y: getY2()
                        );
                    }
                  );
                },
              ),
              right: 16,
            ),
            Positioned(
              child: MaterialButton(
                key: button3Key,
                color: Colors.red,
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BubbleDialog(
                            text: "Text3",
                            height: bubbleHeight,
                            width: bubbleWidth,
                            arrowLocation: ArrowLocation.BOTTOM,
                            x: getX(button3Key) + getWidth(button3Key) / 2,
                            y: getY3()
                        );
                      });
                },
              ),
              bottom: 200,
              left: 32,
            ),
            Positioned(
              child: MaterialButton(
                key: button4Key,
                color: Colors.orange,
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                    return BubbleDialog(
                        text: "Text4",
                        height: bubbleHeight,
                        width: bubbleWidth,
                        arrowLocation: ArrowLocation.LEFT,
                        x: getX(button4Key) + getWidth(button4Key),
                        y: getY4()
                    );
                  });
                },
              ),
              bottom: 100,
              right: 100,
            )
          ],
        ),
      ),
    );
  }

}

class BubbleDialog extends StatelessWidget {

  final String text;

  final double width;

  final double height;

  final double x;

  final double y;

  final double radius;

  final ArrowLocation arrowLocation;

  final VoidCallback voidCallback;

  BubbleDialog({
    this.text,
    this.width,
    this.height,
    this.x,
    this.y,
    this.radius = 4,
    this.arrowLocation,
    this.voidCallback
  });

  confirm(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (){
          confirm(context);
        },
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: BubbleTipWidget(
                arrowLocation: arrowLocation,
                width: width,
                height: height,
                radius: radius,
                x: x,
                y: y,
                text: text,
                voidCallback: (){
                  confirm(context);
                },
              ),
            ),
            Positioned(
                left: x-2,
                top: y-2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
                  ),
                  child: SizedBox(width: 4, height: 4),
                )
            )
          ],
        ),
      ),
    );
  }

}