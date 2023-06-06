import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/ytd_itd_widget.dart';

class TitleSubtitle extends AppStatelessWidget {
  final String title;
  final String subTitle;
  final String? tooltipMessage;
  const TitleSubtitle(
      {super.key,
      required this.title,
      required this.subTitle,
      this.tooltipMessage});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: textTheme.bodySmall),
            if (tooltipMessage!= null)
              Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                textAlign: TextAlign.center,
                message: tooltipMessage,
                child: const InfoIcon(),
              ),
          ],
        ),
        Text(subTitle, style: textTheme.bodyLarge),
      ],
    );
  }
}

class TitleChangeSubtitle extends AppStatelessWidget {
  final String title;
  final String? bigTitle;

  final String subTitle;
  final double value;
  const TitleChangeSubtitle(
      {super.key,
      required this.title,
      this.bigTitle,
      required this.subTitle,
      required this.value});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (bigTitle != null)
          Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(bigTitle!, style: textTheme.bodyLarge)),
        Text(title, style: textTheme.bodySmall),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(subTitle, style: textTheme.bodyLarge),
            ChangeWidget(number: value, text: value.toStringAsFixed(1)),
          ],
        ),
      ],
    );
  }
}
