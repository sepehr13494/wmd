
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_stateless_widget.dart';

class ChangeWidget extends AppStatelessWidget {
  final double number;
  final String text;
  final String? tooltipMessage;

  const ChangeWidget(
      {Key? key, required this.number, required this.text, this.tooltipMessage})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalization) {
    final bool isPositive = number > 0;
    final bool isZero = number == 0;
    final color = isZero ? null : (isPositive ? AppColors.green : Colors.red);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RichText(
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
              text: text,
              style: TextStyle(color: color),
            ),
            if (tooltipMessage != null)
              WidgetSpan(
                child: Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: AppLocalizations.of(context).assets_tooltips_percentageAbsurd,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: InfoIcon(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
