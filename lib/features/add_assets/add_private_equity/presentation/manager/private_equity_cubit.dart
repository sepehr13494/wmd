import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

part 'private_equity_state.dart';

class PrivateEquityCubit extends Cubit<PrivateEquityState> {
  final AddPrivateEquityUseCase addPrivateEquityUseCase;
  PrivateEquityCubit(this.addPrivateEquityUseCase)
      : super(PrivateEquityInitial());

  postPrivateEquity({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await addPrivateEquityUseCase(map);
    result.fold(
        (failure) => emit(ErrorState(failure: failure)),
        (privateEquitySaveResponse) => emit(PrivateEquitySaved(
            privateEquitySaveResponse: privateEquitySaveResponse)));
  }
}
