import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/global_functions.dart';

class DeleteAssetBaseWidget extends AppStatelessWidget {
  final String name;
  final String realAssetName;
  final Function() onTap;

  const DeleteAssetBaseWidget(
      {Key? key,
      required this.name,
      required this.realAssetName,
      required this.onTap})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getTitle(name,appLocalizations),
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            appLocalizations.assetLiabilityForms_labels_removeAsset,
            style: textTheme.bodyMedium,
          ),
          InkWell(
            onTap: () {
              GlobalFunctions.confirmProcess(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textTheme.bodySmall!.color!.withOpacity(0.1)
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.delete,color: Theme.of(context).primaryColor,),
                ),
                reverse: true,
                      context: context,
                      title: AppLocalizations.of(context)
                          .common_deleteAssetModal_title.replaceAll("{{assetName}}", realAssetName),
                      body: AppLocalizations.of(context)
                          .common_deleteAssetModal_description,
                yes: AppLocalizations.of(context)
                    .common_button_delete,
                no: AppLocalizations.of(context)
                    .common_button_cancel,
              )
                  .then((value) {
                if (value) {
                  onTap();
                }
              });
            },
            child: Text(
              AppLocalizations.of(context).common_button_deleteAsset,
              style: textTheme.bodyMedium!.toLinkStyle(context),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(String name, AppLocalizations appLocalizations) {
    switch (name){
      case AssetTypes.bankAccount:
        return appLocalizations.assetLiabilityForms_heading_edit_bankAccount;
      case AssetTypes.realEstate:
        return appLocalizations.assetLiabilityForms_heading_edit_realEstate;
      case AssetTypes.privateEquity:
        return appLocalizations.assetLiabilityForms_heading_edit_privateEquity;
      case AssetTypes.privateDebt:
        return appLocalizations.assetLiabilityForms_heading_edit_privateDebt;
      case AssetTypes.otherAsset:
        return appLocalizations.assetLiabilityForms_heading_edit_otherAssets;
      case AssetTypes.listedAsset:
        return appLocalizations.assetLiabilityForms_heading_edit_listedAssets;
      default:
        return "";
    }
  }
}
