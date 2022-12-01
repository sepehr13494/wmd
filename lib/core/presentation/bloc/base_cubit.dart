import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/presentation/manager/plaid_cubit.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';
import 'package:wmd/features/add_assets/add_listed_security/presentation/manager/listed_security_cubit.dart';
import 'package:wmd/features/add_assets/add_private_debt/presentation/manager/private_debt_cubit.dart';
import 'package:wmd/features/add_assets/add_private_equity/presentation/manager/private_equity_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/add_assets/add_other_asset/presentation/manager/other_asset_cubit.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/video_player_widget/bloc/video_controller_cubit.dart';
import 'package:wmd/features/authentication/verify_email/presentation/manager/verify_email_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import '../../error_and_success/failures.dart';
import '../../error_and_success/succeses.dart';
import '../../../features/splash/presentation/manager/splash_cubit.dart';

part 'base_state.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState) : super();
}
