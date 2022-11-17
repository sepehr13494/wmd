import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/entities/private_debt_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/use_cases/post_private_debt_usecase.dart';

part 'private_debt_state.dart';

class PrivateDebtCubit extends Cubit<PrivateDebtState> {
  final PostPrivateDebtUseCase postPrivateDebtUseCase;

  PrivateDebtCubit(this.postPrivateDebtUseCase) : super(PrivateDebtInitial());

  postPrivateDebt({required Map<String, dynamic> map}) async {
    print(map);
    // emit(LoadingState());
    final result = await postPrivateDebtUseCase(map);
    // result.fold(
    //     (failure) => emit(ErrorState(failure: failure)),
    //     (privateDebtSaveSuccess) => emit(
    //         PrivateDebtSaved(privateDebtSaveResponse: privateDebtSaveSuccess)));
  }
}
