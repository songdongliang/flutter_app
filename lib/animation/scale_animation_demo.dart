import 'package:flutter/material.dart';

class ScaleAnimationRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ScaleAnimationRouteState();

}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation);
//    animation.addListener(() {
//          setState(() {
//
//          });
//    });
    // 启动动画，正向执行
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
//    return Center(
//      child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592368508174&di=2b3d310c72aed1cf179d415bb0e05b5f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"
//        , width: animation.value, height: animation.value,),
//    );
  return AnimatedImage(animation: animation,);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

}

class AnimatedImage extends AnimatedWidget {

  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592368508174&di=2b3d310c72aed1cf179d415bb0e05b5f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"
        , width: animation.value, height: animation.value,),
    );
  }
  
}