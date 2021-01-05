import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';

/// @Date：2021/1/4
/// @Author：songdongliang
/// Desc：
class MoreWidget extends StatelessWidget {

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  const MoreWidget(this.itemCount, this.hasMore, this.pageSize);

  @override
  Widget build(BuildContext context) {
    final TextStyle style = context.isDark ? TextStyles.textGray14 : const TextStyle(color: Color(0x8A000000));
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (hasMore) const CupertinoActivityIndicator(),
          if (hasMore) Gaps.hGap5,
          /// 只有一页的时候，就不显示FootView了
          Text(hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '没有了哦~'), style: style,)
        ],
      ),
    );
  }
  
}