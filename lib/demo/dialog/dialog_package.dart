
import 'package:flutter/material.dart';

class YDDialog extends StatefulWidget{

  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final Color cancelColor;
  bool isCancel = true;
  final bool outsideDismiss;
  final Function confirmCallback;
  final Function cancelCallback;

  YDDialog({Key key, this.title, this.content, this.confirmText,
    this.cancelText, this.confirmColor, this.cancelColor, this.isCancel,
    this.outsideDismiss, this.confirmCallback, this.cancelCallback}): super(key: key);

  @override
  State<StatefulWidget> createState() => _YDDialogState();

}

class _YDDialogState extends State<YDDialog> {

  /// 确定按钮操作
  _confirmDialog() {
    Navigator.of(context).pop();
    if (widget.confirmCallback != null) {
      widget.confirmCallback();
    }
  }

  /// 取消按钮操作
  _cancelDialog() {
    Navigator.of(context).pop();
    if (widget.cancelCallback != null) {
      widget.cancelCallback();
    }
  }

  _dismissDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    Column contentWidget = Column(
      children: <Widget>[
        SizedBox(
          height: widget.title == null ? 0 : 16,
        ),
        Text(
          widget.title == null ? "" : widget.title,
          style: TextStyle(
              color: Color(0xff33394E),
            fontSize: 17
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 24),
          child: Center(
            child: Text(
                widget.content == null ? "" : widget.content,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff474f66)
              ),
            ),
          ),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffe5e5e5),
        ),
        Container(
          height: 46,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: widget.isCancel ? 1 : 0,
                child: widget.isCancel ? GestureDetector(
                  child: Text(
                    widget.cancelText == null ? "取消" : widget.cancelText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.cancelColor,
                        fontSize: 15
                    ),
                  ),
                  onTap: () {
                    _cancelDialog();
                  },
                ) : Text(""),
              ),
              VerticalDivider(
                thickness: widget.isCancel == null ? 0 : 0.5,
                color: Color(0xffeeeff3),
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Text(
                    widget.confirmText == null ? "确定" : widget.confirmText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.confirmColor,
                        fontSize: 15
                    ),
                  ),
                  onTap: () {
                    _confirmDialog();
                  },
                ),
              )
            ],
          ),
        )
      ],
    );

    // return WillPopScope(
    //     child: GestureDetector(
    //       onTap: () {
    //         widget.outsideDismiss ? _dismissDialog() : null;
    //       },
    //       child: Material(
    //         type: MaterialType.transparency,
    //           // clipBehavior: Clip.antiAlias,
    //           child: Center(
    //             child: Container(
    //               constraints: BoxConstraints(),
    //               width: width * 0.8,
    //               // height: 150,
    //               child: contentWidget,
    //               alignment: Alignment.center,
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.circular(8)
    //               ),
    //             ),
    //           )
    //       ),
    //     ),
    //     onWillPop: () async {
    //       return widget.outsideDismiss;
    //     }
    // );
    return Material(
        type: MaterialType.transparency,
        // clipBehavior: Clip.antiAlias,
        child: Container(
          alignment: Alignment.center,
          child: Center(
            child: Container(
              constraints: BoxConstraints(),
              // width: width * 0.8,
              // height: 150,
              child: contentWidget,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
          ),
        )
    );
  }

}

