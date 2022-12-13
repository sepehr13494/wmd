import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import '../../data/models/get_custodian_bank_list_params.dart';
import '../../domain/use_cases/get_custodian_bank_list_usecase.dart';
import '../../domain/entities/custodian_bank_entity.dart';

part 'custodian_bank_list_state.dart';

class CustodianBankListCubit extends Cubit<CustodianBankListState> {
  final GetCustodianBankListUseCase getCustodianBankListUseCase;

  CustodianBankListCubit(
    this.getCustodianBankListUseCase,
  ) : super(LoadingState());

  getCustodianBankList() async {
    emit(LoadingState());
    final result =
        await getCustodianBankListUseCase(GetCustodianBankListParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(CustodianBankListLoaded(custodianBankList: entities));
    });
  }
}
