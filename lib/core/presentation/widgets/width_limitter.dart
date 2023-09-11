import 'package:flutter/material.dart';

class WidthLimiterWidget extends StatelessWidget {
  final Widget child;
  final double width;
  const WidthLimiterWidget({Key? key, required this.child, this.width = 700})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: BoxConstraints(maxWidth: width),
        child: child,
      ),
    );
  }
}
