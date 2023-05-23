import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class AddButton extends AppStatelessWidget {
  final void Function() onTap;
  final bool addAsset;

  const AddButton({
    Key? key,
    required this.onTap,
    this.addAsset = true
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme, AppLocalizations appLocalizations) {
    return ElevatedButton(
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_circle_outlined),
            const SizedBox(width: 8),
            Text((ResponsiveHelper(context: context).isMobile || !addAsset) ? appLocalizations.common_button_add : appLocalizations.common_button_addAsset)
          ],
        ));
  }

}

class AddButtonLiability extends AppStatelessWidget {
  final void Function() onTap;

  const AddButtonLiability({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme, AppLocalizations appLocalizations) {
    return ElevatedButton(
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_circle_outlined),
            const SizedBox(width: 8),
            Text((ResponsiveHelper(context: context).isMobile) ? appLocalizations.common_button_add : appLocalizations.common_button_addLiability)
          ],
        ));
  }

}