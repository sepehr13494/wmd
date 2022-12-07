import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_custodian_bank_list_params.dart';
import '../../domain/use_cases/get_custodian_bank_list_usecase.dart';
import '../../domain/entities/get_custodian_bank_list_entity.dart';
import '../../data/models/post_custodian_bank_status_params.dart';
import '../../domain/use_cases/post_custodian_bank_status_usecase.dart';
import '../../domain/entities/post_custodian_bank_status_entity.dart';
import '../../data/models/get_custodian_bank_status_params.dart';
import '../../domain/use_cases/get_custodian_bank_status_usecase.dart';
import '../../domain/entities/get_custodian_bank_status_entity.dart';

part 'custodian_bank_auth_state.dart';

class CustodianBankAuthCubit extends Cubit<CustodianBankAuthState> {
  final GetCustodianBankListUseCase getCustodianBankListUseCase;
  final PostCustodianBankStatusUseCase postCustodianBankStatusUseCase;
  final GetCustodianBankStatusUseCase getCustodianBankStatusUseCase;

  CustodianBankAuthCubit(
    this.getCustodianBankListUseCase,
    this.postCustodianBankStatusUseCase,
    this.getCustodianBankStatusUseCase,
  ) : super(LoadingState());

  getCustodianBankList() async {
    emit(LoadingState());
    final result =
        await getCustodianBankListUseCase(GetCustodianBankListParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {});
  }

  postCustodianBankStatus(PostCustodianBankStatusParams params) async {
    emit(LoadingState());
    final result = await postCustodianBankStatusUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {});
  }

  getCustodianBankStatus(GetCustodianBankStatusParams params) async {
    emit(LoadingState());
    final result = await getCustodianBankStatusUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {});
  }
}
