import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/settings/linked_accounts/domain/use_cases/delete_linked_accounts_usecase.dart';

import '../../data/models/get_linked_accounts_params.dart';
import '../../domain/use_cases/get_linked_accounts_usecase.dart';
import '../../domain/entities/get_linked_accounts_entity.dart';

part 'linked_accounts_state.dart';

class LinkedAccountsCubit extends Cubit<LinkedAccountsState> {
  final GetLinkedAccountsUseCase getLinkedAccountsUseCase;
  final DeleteLinkedAccountsUseCase deleteLinkedAccountsUseCase;

  LinkedAccountsCubit(
    this.getLinkedAccountsUseCase,
    this.deleteLinkedAccountsUseCase,
  ) : super(LoadingState());

  getLinkedAccounts() async {
    emit(LoadingState());
    final result = await getLinkedAccountsUseCase(GetLinkedAccountsParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(GetLinkedAccountsLoaded(getLinkedAccountsEntities: entities));
    });
  }

  deleteLinkedAccounts(DeleteCustodianBankStatusParams param) async {
    emit(LoadingState());
    final res = await deleteLinkedAccountsUseCase(param);
    final result = await getLinkedAccountsUseCase(const GetLinkedAccountsParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(GetLinkedAccountsLoaded(getLinkedAccountsEntities: entities));
    });
  }
}
