import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankSaveState> {
  final PostBankDetailsUseCase postBankDetailsUseCase;
  BankCubit(this.postBankDetailsUseCase) : super(BankDetailInitial());

  postBankDetails({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final bankSaveParam = BankSaveParams.fromJson(map);
    final result = await postBankDetailsUseCase(bankSaveParam);
    result.fold(
        (failure) => emit(ErrorState(failure: failure)),
        (bankSaveSuccess) =>
            emit(BankDetailSaved(bankSaveResponse: bankSaveSuccess)));
  }
}
