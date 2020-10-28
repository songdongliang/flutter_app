import 'package:flutter/material.dart';

class TransformDemoPage extends StatelessWidget {

  getHeader(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, -30),
        child: Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Theme.of(context).cardColor, blurRadius: 4.0)],
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://wx1.sinaimg.cn/mw690/87137895ly1gha84jnk0gj21s02fuqv6.jpg")
            )
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Transform Demo Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Card(
          margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 150,
            child: Column(
              children: <Widget>[
                getHeader(context),
                Text(
                  "Flutter is Google's portable UI toolkit for crafting "
                      "beautiful, natively compiled applications for mobile, "
                      "web, and desktop from a single codebase. Flutter is Google's portable UI toolkit for crafting "
                      "beautiful, natively compiled applications for mobile, "
                      "web, and desktop from a single codebase. ",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

}