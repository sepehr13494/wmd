import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/util/app_restart.dart';
import 'package:wmd/core/util/loading/loading_screen.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal_onboarding.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssetBlocHelper extends BlocHelper {
  static BlocWidgetListener defaultBlocListener({
    required BlocWidgetListener listener,
    required String asset,
    required String assetType,
  }) {
    return BlocHelper.defaultBlocListener(listener: (context, state) {
      final appLocalizations = AppLocalizations.of(context);
      if (state is AddAssetState) {
        context.read<MainDashboardCubit>().initPage();
        context.read<AssetsOverviewCubit>().initPage();
        context.read<DashboardAllocationCubit>().getAllocation(
            dateTime: context.read<MainDashboardCubit>().dateTimeRange);
        context.read<DashboardGoeCubit>().getGeographic();
        context.read<DashboardPieCubit>().getPie();

        final successValue = state.addAsset;
        showDialog(
          context: context,
          builder: (buildContext) {
            final isAssetsNotEmpty = context
                .read<MainDashboardCubit>()
                .netWorthObj
                ?.assets
                .currentValue !=
                0;
            final isLiabilityNotEmpty = context
                .read<MainDashboardCubit>()
                .netWorthObj
                ?.liabilities
                .currentValue !=
                0;

            if (isAssetsNotEmpty || isLiabilityNotEmpty) {
              return SuccessModalWidget(
                assetId: successValue.id,
                assetType: assetType,
                title: '$asset is successfully added to wealth overview',
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
            }
            return SuccessModalOnboardingWidget(
              title: '$asset is successfully added to wealth overview',
              confirmBtn:
              appLocalizations.common_formSuccessModal_buttons_viewAsset,
              cancelBtn:
              appLocalizations.common_formSuccessModal_buttons_addAsset,
              startingBalance: successValue.startingBalance.convertMoney(),
              currencyCode: successValue.currencyCode,
              currencyRate: successValue.currencyRate,
              netWorth: successValue.totalNetWorth.convertMoney(),
              netWorthChange: successValue.totalNetWorthChange.convertMoney(),
            );

            // return SuccessModalWidget(
            //   title: '$asset is successfully added to wealth overview',
            //   confirmBtn:
            //       appLocalizations.common_formSuccessModal_buttons_viewAsset,
            //   cancelBtn:
            //       appLocalizations.common_formSuccessModal_buttons_addAsset,
            //   startingBalance: successValue.startingBalance.convertMoney(),
            //   currencyCode: successValue.currencyCode,
            //   currencyRate: successValue.currencyRate,
            //   netWorth: successValue.totalNetWorth.convertMoney(),
            //   netWorthChange: successValue.totalNetWorthChange.convertMoney(),
            // );
          },
        );
      }
    },);
  }
}
