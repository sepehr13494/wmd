import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import '../../error_and_success/failures.dart';
import '../../error_and_success/succeses.dart';
import '../../../features/splash/presentation/manager/splash_cubit.dart';

part 'base_state.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState) : super();
}
