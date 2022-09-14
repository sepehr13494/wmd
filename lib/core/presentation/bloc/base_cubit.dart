import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

part 'base_state.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState) : super();

}
