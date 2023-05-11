import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/round_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/change_widget.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YtdItdWidget extends AppStatelessWidget {
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
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    List items = [
      [
        AppLocalizations.of(context).assets_label_ytd,
        ytd,
        "${ytd.toStringFixedZeroless()}%",
        appLocalizations.assets_tooltips_ytd
        // "Year-to-date:the period from the first of\nthe calendar year to date of the\ncommunication."
      ],
      [
        AppLocalizations.of(context).assets_label_itd,
        itd,
        "${itd.toStringFixedZeroless()}%",
        appLocalizations.assets_tooltips_itd
        // "Incenption-to-date:the period from the\nestablishment of the portfolio/investment to\nthe date of the communication."
      ],
    ];
    if (reversed) {
      items = items.reversed.toList();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: ChangeWidget(
                            number: item[1],
                            text: item[2],
                            tooltipMessage:
                                (item[1] >= 99900 || item[1] <= -100)
                                    ? ""
                                    : null),
                      ),
                    ),
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
