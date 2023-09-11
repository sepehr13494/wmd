import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

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

    final List<String> bulletTexts =
        calculateBulletTexts(appLocalizations, widget.assetType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.common_assetConfirmationModal_heading.replaceAll(
              '{{assetName}}',
              AssetTypes.getAssetType(appLocalizations, widget.assetType)
                  .toLowerCase()),
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          '\u2022 ${bulletTexts[0]}',
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          '\u2022 ${bulletTexts[1]}',
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          '\u2022 ${appLocalizations.common_assetConfirmationModal_listItem3}',
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Divider(color: AppColors.dashboardDividerColor.withOpacity(0.5)),
        const SizedBox(height: 4),
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
                        color: AppColors.primaryLighter,
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
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildCheckBox(appLocalizations, textTheme),
                Expanded(child: buildCancelBtn(appLocalizations)),
                Expanded(child: buildConfirmBtn(appLocalizations)),
              ],
            ),
          )
      ],
    );
  }

  List<String> calculateBulletTexts(
      AppLocalizations appLocalizations, String assetType) {
    switch (assetType) {
      case AssetTypes.bankAccount:
        return [
          appLocalizations.common_assetConfirmationModal_bankAccount_listItem1,
          appLocalizations.common_assetConfirmationModal_bankAccount_listItem2
        ];
      case AssetTypes.realEstate:
        return [
          appLocalizations.common_assetConfirmationModal_realEstate_listItem1,
          appLocalizations.common_assetConfirmationModal_realEstate_listItem2
        ];
      case AssetTypes.privateEquity:
        return [
          appLocalizations
              .common_assetConfirmationModal_privateEquity_listItem1,
          appLocalizations.common_assetConfirmationModal_privateEquity_listItem2
        ];
      case AssetTypes.privateDebt:
        return [
          appLocalizations.common_assetConfirmationModal_privateDebt_listItem1,
          appLocalizations.common_assetConfirmationModal_privateDebt_listItem2
        ];
      case AssetTypes.listedAsset:
        return [
          appLocalizations.common_assetConfirmationModal_listedAssets_listItem1,
          appLocalizations.common_assetConfirmationModal_listedAssets_listItem2
        ];
      case AssetTypes.otherAsset:
        return [
          appLocalizations.common_assetConfirmationModal_otherAssets_listItem1,
          appLocalizations.common_assetConfirmationModal_otherAssets_listItem2
        ];
      default:
        return [
          appLocalizations.common_assetConfirmationModal_listItem1,
          appLocalizations.common_assetConfirmationModal_listItem2
        ];
    }
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
