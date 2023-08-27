import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';

Future<dynamic> showAddAssetSuccessModalV2(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context);
  final textTheme = Theme.of(context).textTheme;
  final responsiveHelper = ResponsiveHelper(context: context);

  return showDialog(
    context: context,
    builder: (context) {
      return CenterModalWidget(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.common_assetConfirmationModal_heading,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '\u2022 ${appLocalizations.common_assetConfirmationModal_listItem1}',
              style: textTheme.bodySmall,
            ),
            Text(
              '\u2022 ${appLocalizations.common_assetConfirmationModal_listItem2}',
              style: textTheme.bodySmall,
            ),
            Text(
              '\u2022 ${appLocalizations.common_assetConfirmationModal_listItem2}',
              style: textTheme.bodySmall,
            ),
            const Divider(color: AppColors.dashboardDividerColor),
            Card(
              color: AppColors.blueCardColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  text: TextSpan(
                    style: textTheme.bodySmall,
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 15,
                          ),
                        ),
                      ),
                      TextSpan(
                        text:
                            appLocalizations.common_assetConfirmationModal_note,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (responsiveHelper.isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCheckBox(appLocalizations, textTheme),
                  _buildConfirmBtn(appLocalizations),
                  _buildCancelBtn(appLocalizations),
                ],
              ),
            if (!responsiveHelper.isMobile)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCheckBox(appLocalizations, textTheme),
                  _buildConfirmBtn(appLocalizations, isTablet: true),
                  _buildCancelBtn(appLocalizations, isTablet: true),
                ],
              )
          ],
        ),
      );
    },
  );
}

Widget _buildCancelBtn(AppLocalizations appLocalizations,
    {bool isTablet = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: OutlinedButton(
      onPressed: () {},
      style:
          OutlinedButton.styleFrom(minimumSize: Size(isTablet ? 100 : 200, 50)),
      child: Text(appLocalizations.common_button_cancel),
    ),
  );
}

Widget _buildConfirmBtn(AppLocalizations appLocalizations,
    {bool isTablet = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () {},
      style:
          ElevatedButton.styleFrom(minimumSize: Size(isTablet ? 100 : 200, 50)),
      child: Text(appLocalizations.common_button_confirm),
    ),
  );
}

Widget _buildCheckBox(AppLocalizations appLocalizations, TextTheme textTheme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Checkbox(
        value: false,
        onChanged: (val) {},
      ),
      Text(
        appLocalizations.common_assetConfirmationModal_checkbox,
        style: textTheme.bodySmall,
      ),
    ],
  );
}
