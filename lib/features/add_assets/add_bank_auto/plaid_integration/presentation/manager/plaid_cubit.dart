import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/usecase/link_plaid_usecase.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';

part 'plaid_state.dart';

class PlaidCubit extends Cubit<PlaidState> {
  final PlaidLinkUseCase plaidLinkUseCase;

  PlaidCubit(this.plaidLinkUseCase) : super(PlaidInitialState());

  linkPlaidAccount(BankEntity bank) async {
    emit(LoadingState());
    final result = await plaidLinkUseCase(bank);
    result.fold(
        (l) => emit(ErrorState(failure: l)), (r) => emit(PlaidLinkSuccess()));
  }
}
