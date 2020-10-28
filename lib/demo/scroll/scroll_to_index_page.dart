import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ScrollToIndexPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ScrollToIndexPageState();

}

class _ScrollToIndexPageState extends State<ScrollToIndexPage> {

  static const maxCount = 100;

  final random = math.Random();

  /// pub scroll_to_index下的controller
  AutoScrollController controller;

  final scrollDirection = Axis.vertical;

  List<List<int>> randomList;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection
    );
    randomList = List.generate(maxCount, (index) => <int>[index, (1000 * random.nextDouble()).toInt()]);
  }

  Widget _getRow(int index, double height) {
    return _wrapScrollTag(
      index: index,
      child: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.topCenter,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue, width: 4)
        ),
        child: Text("index: $index, height: $height"),
      )
    );
  }

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
    index: index,
    key: ValueKey(index),
    controller: controller,
    child: child,
    highlightColor: Colors.black.withOpacity(0.1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrollToIndexPage"),
      ),
      body: Container(
        child: ListView(
          scrollDirection: scrollDirection,
          controller: controller,
          children: randomList.map<Widget>((data) =>
            Padding(
              padding: EdgeInsets.all(8),
              child: _getRow(data[0], math.max(data[1].toDouble(), 50.0)),
            )
          ).toList(),
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () async {
            await controller.scrollToIndex(13, preferPosition: AutoScrollPosition.begin);
            controller.highlight(13);
          },
          child: Text("Scroll To Index 13"),
        )
      ],
    );
  }

}