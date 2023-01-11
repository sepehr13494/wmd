import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class SummaryTitle extends StatefulWidget {
  const SummaryTitle({
    Key? key,
  }) : super(key: key);

  @override
  AppState<SummaryTitle> createState() => _SummaryTitleState();
}

class _SummaryTitleState extends AppState<SummaryTitle> {
  static const _timeFilter = [
    // MapEntry<String, int>("All times", 0),
    MapEntry<String, int>("7 days", 7),
    MapEntry<String, int>("30 days", 30),
  ];

  MapEntry<String, int> selectedTimeFilter = _timeFilter.first;
  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(appLocalizations.assets_summary, style: textTheme.bodyLarge),
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 15,
              color: primaryColor,
            ),
            const SizedBox(width: 4),
            DropdownButton<MapEntry<String, int>>(
              items: _timeFilter
                  .map((e) => DropdownMenuItem<MapEntry<String, int>>(
                      value: e,
                      child: Text(
                        e.key,
                        style: textTheme.bodyMedium!.apply(color: primaryColor),
                        // textTheme.bodyMedium!.toLinkStyle(context),
                      )))
                  .toList(),
              onChanged: ((value) {
                if (value != null) {
                  // setState(() {
                  //   selectedTimeFilter = value;
                  // });
                }
              }),
              value: selectedTimeFilter,
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 15,
                color: primaryColor,
              ),
              // style: textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}
