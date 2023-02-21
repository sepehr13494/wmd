import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/util/colors.dart';

class ChangeWidget extends StatelessWidget {
  final double number;
  final String text;
  final String? tooltipMessage;

  const ChangeWidget(
      {Key? key, required this.number, required this.text, this.tooltipMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPositive = number > 0;
    final bool isZero = number == 0;
    final color = isZero ? null : (isPositive ? AppColors.green : Colors.red);
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: isZero
                ? const SizedBox()
                : Icon(
                    isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: color,
                    size: 20,
                  ),
          ),
          TextSpan(
            text: isZero ? '0%' : text,
            style: TextStyle(color: color),
          ),
          if (tooltipMessage != null)
            const WidgetSpan(
              child: Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: "The performance computation maybe incorrect and the incoming data for the custodian bank needs to be checked",
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: InfoIcon(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
