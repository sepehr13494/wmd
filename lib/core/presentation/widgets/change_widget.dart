import 'package:flutter/material.dart';

class ChangeWidget extends StatelessWidget {
  final double number;
  final String text;
  const ChangeWidget({Key? key, required this.number, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPositive = number > 0;
    final bool isZero = number == 0;
    final color = isZero ? null : (isPositive ? Colors.green : Colors.red);
    return Row(
      children: [
        isZero ? const SizedBox() : Icon(isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,color: color,),
        Text(text,style: TextStyle(color: color),),
      ],
    );
  }
}
