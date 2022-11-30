import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/data/models/bank_account_params.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/domain/entities/bank_account_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/features/assets_overview/asset_detail/bank_account/domain/usecase/get_bank_account_usecase.dart';

part 'bank_account_states.dart';

class BankAccountCubit extends Cubit<BankAccountState> {
  final GetBankAccountUseCase getBankAccountUseCase;
  BankAccountCubit(this.getBankAccountUseCase) : super(LoadingState());

  getBankAccount(BankAccountParams param) async {
    emit(LoadingState());
    final result = await getBankAccountUseCase(param);
    result.fold((failure) => emit(ErrorState(failure: failure)), (bankAccount) {
      emit(BankAccountLoaded(bankAccount));
    });
  }
}
