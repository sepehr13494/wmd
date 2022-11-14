import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/widgets/support_widget.dart';
import 'package:wmd/global_functions.dart';

class AddAssetFooter extends AppStatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  final bool? enableAddButton;
  const AddAssetFooter(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.enableAddButton})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
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
                              // context.pop();
                              GlobalFunctions.showExitDialog(
                                  context: context,
                                  onExitClick: () => context.pop());
                            },
                            child: const Text("Back"))),
                    const SizedBox(width: 12),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: enableAddButton == true ? onTap : null
                            //     () {
                            //   // onTap
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return SuccessModalWidget(
                            //         title:
                            //             '[Asset] is successfully added to wealth overview',
                            //         confirmBtn: appLocalizations
                            //             .common_formSuccessModal_buttons_viewAsset,
                            //         cancelBtn: appLocalizations
                            //             .common_formSuccessModal_buttons_addAsset,
                            //         aquiredCost: '\$1,000,000',
                            //         marketPrice: '\$3,000,000',
                            //         netWorth: '\$5,000,000',
                            //       );
                            //     },
                            //   ).then((isConfirm) {
                            //     if (isConfirm != null && isConfirm == true) {
                            //       context.pop();
                            //     }
                            //   });
                            // }
                            ,
                            child: Text(buttonText))),
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
