import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';

import 'app_stateless_widget.dart';

class BankTooltip extends AppStatelessWidget {
  final Widget child;
  final bool showTooltip;
  const BankTooltip({
    super.key,
    required this.child,
    required this.showTooltip,
  });

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        if (showTooltip)
          Tooltip(
            showDuration: const Duration(seconds: 5),
            message: appLocalizations.assets_tooltip_bankAccountException,
            triggerMode: TooltipTriggerMode.tap,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: InfoIcon(),
            ),
          )
      ],
    );
  }
}
