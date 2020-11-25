import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogLoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 36,
        height: 36,
        child: Lottie.asset("assets/lottie/general_loading.json", width: 36, height: 36),
      ),
    );
  }

}