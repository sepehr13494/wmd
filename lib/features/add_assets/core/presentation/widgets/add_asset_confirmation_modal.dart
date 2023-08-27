import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';

Future<ModalResponse?> showAssetConfirmationModal(BuildContext context,
    {required assetType}) {
  return showDialog<ModalResponse?>(
    context: context,
    builder: (context) {
      return CenterModalWidget(
        body: AssetConfirmationModalWidget(assetType: assetType),
      );
    },
  );
}

class AssetConfirmationModalWidget extends StatefulWidget {
  const AssetConfirmationModalWidget({
    Key? key,
    required this.assetType,
  }) : super(key: key);

  final String assetType;

  @override
  AppState<AssetConfirmationModalWidget> createState() =>
      _AssetConfirmationModalWidgetState();
}

class _AssetConfirmationModalWidgetState
    extends AppState<AssetConfirmationModalWidget> {
  bool isChecked = false;

  Widget buildCancelBtn(AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context, ModalResponse(false, false));
        },
        // style:
        //     OutlinedButton.styleFrom(minimumSize: Size(isTablet ? 100 : 200, 50)),
        child: Text(appLocalizations.common_button_cancel),
      ),
    );
  }

  Widget buildConfirmBtn(AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, ModalResponse(isChecked, true));
        },
        // style:
        //     ElevatedButton.styleFrom(minimumSize: Size(isTablet ? 100 : 200, 50)),
        child: Text(appLocalizations.common_button_confirm),
      ),
    );
  }

  Widget buildCheckBox(AppLocalizations appLocalizations, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (val) {
            if (val == null) return;
            setState(() {
              isChecked = val;
            });
          },
        ),
        Text(
          appLocalizations.common_assetConfirmationModal_checkbox,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.common_assetConfirmationModal_heading
              .replaceAll('{{assetName}}', widget.assetType),
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
                    text: appLocalizations.common_assetConfirmationModal_note,
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
              buildCheckBox(appLocalizations, textTheme),
              buildConfirmBtn(appLocalizations),
              buildCancelBtn(appLocalizations),
            ],
          ),
        if (!responsiveHelper.isMobile)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildCheckBox(appLocalizations, textTheme),
              buildConfirmBtn(appLocalizations),
              buildCancelBtn(appLocalizations),
            ],
          )
      ],
    );
  }
}

class ModalResponse {
  final bool isDontShowSelected;
  final bool isConfirmed;

  ModalResponse(this.isDontShowSelected, this.isConfirmed);

  @override
  String toString() =>
      'isDontShowconfirmed: $isDontShowSelected, isConfirmed: $isConfirmed';
}
