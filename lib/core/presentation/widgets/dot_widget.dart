import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final Color color;
  final double width;
  const DotWidget({Key? key, required this.color, this.width = 8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
    );
  }
}
