import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/util/app_restart.dart';
import 'package:wmd/core/util/loading/loading_screen.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/success_modal.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssetBlocHelper extends BlocHelper {
  static BlocWidgetListener defaultBlocListener({
    required BlocWidgetListener listener,
    required String asset,
  }) {
    return (context, state) {
      final appLocalizations = AppLocalizations.of(context);
      if (state is LoadingState) {
        LoadingOverlay().show(context: context, text: state.message);
      } else if (state is ErrorState) {
        LoadingOverlay().hide();
        // GlobalFunctions.showSnackBar(context, state.failure.message,
        //     color: Colors.red[800], type: "error");
        if (state.failure is ServerFailure) {
          switch ((state.failure as ServerFailure).type) {
            case ExceptionType.normal:
            case ExceptionType.format:
            case ExceptionType.unExpected:
              if (state.tryAgainFunction != null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(state.failure.message),
                                state.tryAgainFunction == null
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          if (state.tryAgainFunction != null) {
                                            Navigator.pop(context);
                                            state.tryAgainFunction!();
                                          }
                                        },
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Text("tryAgain")),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                GlobalFunctions.showSnackBar(context, state.failure.message,
                    color: Colors.red[800], type: "error");
              }
              break;
            case ExceptionType.auth:
              GlobalFunctions.showSnackBar(context, state.failure.message);
              sl<LocalStorage>().logout();
              AppRestart.restart(context);
              break;
          }
        } else {
          GlobalFunctions.showSnackBar(context, state.failure.message,
              color: Colors.red[800], type: "error");
        }
      } else {
        if (state is SuccessState) {
          debugPrint(state.appSuccess.message);
        }
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
            builder: (context) {
              return SuccessModalWidget(
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
            },
          );
        }
        LoadingOverlay().hide();
        listener(context, state);
      }
    };
  }
}
