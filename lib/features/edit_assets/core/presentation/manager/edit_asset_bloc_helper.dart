import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_summary_params.dart';
import 'package:wmd/features/asset_detail/core/presentation/manager/asset_summary_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/global_functions.dart';

class EditAssetBlocHelper{
  static BlocWidgetListener defaultBlocListener({
    required String assetId,
  }) {
    return BlocHelper.defaultBlocListener(listener: (context, state) {
      if (state is EditAssetSuccess) {
        context.read<AssetSummaryCubit>().getSummary(GetSummaryParams(days: 7, assetId: assetId));
        context.read<AssetsOverviewCubit>().initPage();
        context.pop();
      }
      if (state is DeleteAssetSuccess) {
        GlobalFunctions.showSnackBar(context, "Asset Deleted",type: "success");
        context.goNamed(AppRoutes.main);
      }
    },);
  }
}
