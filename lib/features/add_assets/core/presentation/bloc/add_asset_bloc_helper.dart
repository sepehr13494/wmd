import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_router.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/widgets/real_estate_success_modal.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal_onboarding.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssetBlocHelper extends BlocHelper {
  static BlocWidgetListener defaultBlocListener({
    required BlocWidgetListener listener,
    required String asset,
    required String assetType,
  }) {
    return BlocHelper.defaultBlocListener(
      listener: (context, state) {
        final appLocalizations = AppLocalizations.of(context);

        if (state is AddAssetState) {
          /*context.read<MainDashboardCubit>().initPage();
          context.read<AssetsOverviewCubit>().initPage();
          context.read<DashboardAllocationCubit>().getAllocation(
              dateTime: context.read<MainDashboardCubit>().dateTimeRange);
          context.read<DashboardGoeCubit>().getGeographic();
          context.read<DashboardPieCubit>().getPie();*/
          AppRouter().setMainRefreshKey();
          final successValue = state.addAsset;
          if (assetType == AssetTypes.realEstate) {
            showRealEstateSuccessModal(context);
          } else {
            showDialog(
              context: context,
              builder: (buildContext) {
                final isAssetsNotEmpty = context
                        .read<MainDashboardCubit>()
                        .netWorthObj
                        ?.assets
                        .newAssetCount !=
                    0;
                final isLiabilityNotEmpty = context
                        .read<MainDashboardCubit>()
                        .netWorthObj
                        ?.liabilities
                        .newLiabilityCount !=
                    0;
                final isCurrentValueNotEmpty = context
                        .read<MainDashboardCubit>()
                        .netWorthObj
                        ?.totalNetWorth
                        ?.currentValue !=
                    0;

                if (isAssetsNotEmpty ||
                    isLiabilityNotEmpty ||
                    isCurrentValueNotEmpty) {
                  return SuccessModalWidget(
                    assetId: successValue.id,
                    assetType: assetType,
                    title: appLocalizations.common_formSuccessModal_title
                        .replaceAll('{{assetType}}', asset),
                    confirmBtn: appLocalizations
                        .common_formSuccessModal_buttons_viewAsset,
                    cancelBtn: appLocalizations
                        .common_formSuccessModal_buttons_addAsset,
                    startingBalance:
                        successValue.startingBalance.convertMoney(),
                    currencyCode: successValue.currencyCode,
                    currencyRate: successValue.currencyRate,
                    netWorth: successValue.totalNetWorth.convertMoney(),
                    netWorthChange:
                        successValue.totalNetWorthChange.convertMoney(),
                  );
                }
                return SuccessModalOnboardingWidget(
                  title: AssetLoclHelper.getName(
                      asset, assetType, appLocalizations),
                  confirmBtn: appLocalizations
                      .common_formSuccessModal_buttons_viewAsset,
                  cancelBtn:
                      appLocalizations.common_formSuccessModal_buttons_addAsset,
                  startingBalance: successValue.startingBalance.convertMoney(),
                  currencyCode: successValue.currencyCode,
                  currencyRate: successValue.currencyRate,
                  netWorth: successValue.totalNetWorth.convertMoney(),
                  netWorthChange:
                      successValue.totalNetWorthChange.convertMoney(),
                );
              },
            );
          }
        }
      },
    );
  }
}

class AssetLoclHelper {
  static String getName(
      asset, String assetType, AppLocalizations appLocalizations) {
    final title = appLocalizations.common_formSuccessModal_newUser_description;
    String assetName = "";

    switch (assetType) {
      case AssetTypes.bankAccount:
        assetName = appLocalizations.assets_assets_BankAccount;
        break;
      case AssetTypes.listedAsset:
        assetName = appLocalizations.assets_assets_ListedAsset;
        break;
      case AssetTypes.listedAssetEquity:
        assetName = appLocalizations.assets_assets_ListedAsset;
        break;
      case AssetTypes.listedAssetFixedIncome:
        assetName = appLocalizations.assets_assets_ListedAsset;
        break;
      case AssetTypes.listedAssetOther:
        assetName = appLocalizations.assets_assets_ListedAsset;
        break;
      case AssetTypes.listedAssetOtherAsset:
        assetName = appLocalizations.assets_assets_ListedAsset;
        break;
      case AssetTypes.otherAsset:
        assetName = appLocalizations.assets_assets_OtherAssets;
        break;
      case AssetTypes.otherAssets:
        assetName = appLocalizations.assets_assets_OtherAssets;
        break;
      case AssetTypes.privateDebt:
        assetName = appLocalizations.assets_assets_PrivateDebt;
        break;
      case AssetTypes.privateEquity:
        assetName = appLocalizations.assets_assets_PrivateEquity;
        break;
      case AssetTypes.realEstate:
        assetName = appLocalizations.assets_assets_RealEstate;
        break;
      default:
    }

    return title
        .replaceAll('{{assetName}}', "")
        .replaceAll("{{assetType}}", assetName);
  }
}
