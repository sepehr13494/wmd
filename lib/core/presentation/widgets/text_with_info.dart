import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/util/colors.dart';

class TextWithInfo extends StatelessWidget {
  final String title;
  final bool hasInfo;
  final bool showRequired;
  final IconData? icon;
  final String tooltipText;
  const TextWithInfo(
      {Key? key,
      required this.title,
      this.tooltipText = "text",
      this.showRequired = false,
      this.icon = Icons.info,
      required this.hasInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(color: Color(0xffAAAAAA)),
        ),
        const SizedBox(width: 4),
        if (showRequired)
          const Text(
            "*",
            style: TextStyle(color: Color(0xffAAAAAA)),
          ),
        const SizedBox(width: 4),
        hasInfo
            ? Tooltip(
                showDuration: const Duration(seconds: 5),
                triggerMode: TooltipTriggerMode.tap,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.anotherCardColorForDarkTheme
                        : AppColors.anotherCardColorForLightTheme),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                message: tooltipText,
                child: InfoIcon(icon: icon),
              )
            : const SizedBox()
      ],
    );
  }
}
