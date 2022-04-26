// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class Tween_animation extends StatelessWidget {
  final Widget my_child;
  const Tween_animation({
    Key? key,
    required this.my_child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation(
      tween: Tween<double>(begin: .0, end: 150.0),
      curve: Curves.linear,
      duration: Duration(milliseconds: 500),
      builder: (con, child, double val) => Transform(
        transform: Matrix4.identity()..setRotationX(val / 100),
        child: my_child,
      ),
      onComplete: () {
        print("onComplete");
      },
      onStart: () {
        print("start");
      },
    );
  }
}
