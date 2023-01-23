import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/ytd_itd_widget.dart';

class TitleSubtitle extends AppStatelessWidget {
  final String title;
  final String subTitle;
  const TitleSubtitle({super.key, required this.title, required this.subTitle});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: textTheme.bodySmall),
        Text(subTitle, style: textTheme.bodyLarge),
      ],
    );
  }
}

class TitleChangeSubtitle extends AppStatelessWidget {
  final String title;
  final String subTitle;
  final double value;
  const TitleChangeSubtitle(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.value});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: textTheme.bodySmall),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(subTitle, style: textTheme.bodyLarge),
            ChangeWidget(number: value, text: value.toString()),
          ],
        ),
      ],
    );
  }
}
