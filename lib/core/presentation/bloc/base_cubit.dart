import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/video_player_widget/bloc/video_controller_cubit.dart';
import 'package:wmd/features/authentication/verify_email/presentation/manager/verify_email_cubit.dart';
import '../../error_and_success/failures.dart';
import '../../error_and_success/succeses.dart';
import '../../../features/splash/presentation/manager/splash_cubit.dart';

part 'base_state.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState) : super();
}
