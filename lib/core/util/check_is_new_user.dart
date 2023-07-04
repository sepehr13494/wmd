import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

// true if not new user, false if new user
bool checkNotNewUser(MainDashboardState state) {
  if (state is MainDashboardNetWorthLoaded) {
    final isAssetsNotEmpty = state.netWorthObj.assets.newAssetCount != 0;
    final isLiabilityNotEmpty =
        state.netWorthObj.liabilities.newLiabilityCount != 0;

    return isAssetsNotEmpty || isLiabilityNotEmpty;
  } else {
    return false;
  }
}
