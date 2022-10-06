import 'package:flutter/material.dart';

class WidthLimiterWidget extends StatelessWidget {
  final Widget child;
  const WidthLimiterWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: child,
    );
  }
}
