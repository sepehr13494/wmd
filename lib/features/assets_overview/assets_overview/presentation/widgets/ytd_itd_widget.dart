import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class YtdItdWidget extends StatelessWidget {
  final bool expand;
  final double ytd;
  final double itd;
  final bool showToolTip;
  final bool reversed;

  const YtdItdWidget(
      {Key? key,
      this.expand = false,
      this.reversed = false,
      required this.ytd,
      required this.itd,
      this.showToolTip = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = [
      [
        AppLocalizations.of(context).assets_label_ytd,
        ytd,
        "${ytd.toStringAsFixed(1)}%",
        "Year-to-date:the period from the first of\nthe calendar year to date of the\ncommunication."
      ],
      [
        AppLocalizations.of(context).assets_label_itd,
        itd,
        "${itd.toStringAsFixed(1)}%",
        "Incenption-to-date:the period from the\nestablishment of the portfolio/investment to\nthe date of the communication."
      ],
    ];
    if (reversed) {
      items = items.reversed.toList();
    }
    return Row(
      children: List.generate(2, (index) {
        final item = items[index];
        return ExpandedIf(
          expanded: expand,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: expand ? 2 : 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item[0],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 4),
                        if (showToolTip)
                          Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            textAlign: TextAlign.center,
                            message: item[3],
                            child: const InfoIcon(),
                          ),
                      ],
                    ),
                    ChangeWidget(number: item[1], text: item[2],tooltipMessage: (item[1] >= 99900 ||
                        item[1] <= -100)
                        ? AppLocalizations.of(context)
                        .assets_tooltips_percentageAbsurd
                        : null,),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
