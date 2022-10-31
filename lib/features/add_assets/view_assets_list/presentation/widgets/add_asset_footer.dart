import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';

class AddAssetFooter extends AppStatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const AddAssetFooter({Key? key, required this.buttonText,required this.onTap}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return Container(
      width: double.maxFinite,
      height: 60,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            isMobile
                ? const SizedBox()
                : Expanded(
              child: Row(
                children: [
                  const SupportWidget(),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Center(
                          child: Text(
                            "You can add another asset on the next screen",
                            style: textTheme.bodySmall,
                          ))),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            ExpandedIf(
              expanded: isMobile,
              child: SizedBox(
                width: isMobile ? double.maxFinite : 300,
                child: Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              context.pop();
                            }, child: Text("Back"))),
                    const SizedBox(width: 12),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: onTap, child: Text(buttonText))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
