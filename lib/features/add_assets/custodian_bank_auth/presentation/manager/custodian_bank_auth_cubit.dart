import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/post_custodian_bank_status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/delete_custodian_bank_status_usecase.dart';
import '../../domain/entities/custodian_bank_entity.dart';
import '../../data/models/post_custodian_bank_status_params.dart';
import '../../domain/use_cases/post_custodian_bank_status_usecase.dart';
import '../../data/models/get_custodian_bank_status_params.dart';
import '../../domain/use_cases/get_custodian_bank_status_usecase.dart';

part 'custodian_bank_auth_state.dart';

class CustodianBankAuthCubit extends Cubit<CustodianBankAuthState> {
  final PostCustodianBankStatusUseCase postCustodianBankStatusUseCase;
  final GetCustodianBankStatusUseCase getCustodianBankStatusUseCase;
  final DeleteCustodianBankStatusUseCase deleteCustodianBankStatusUseCase;

  CustodianBankAuthCubit(
    this.postCustodianBankStatusUseCase,
    this.getCustodianBankStatusUseCase,
    this.deleteCustodianBankStatusUseCase,
  ) : super(LoadingState());

  postCustodianBankStatus(PostCustodianBankStatusParams params) async {
    emit(LoadingState());

    final result = await postCustodianBankStatusUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(CustodianBankStateUpdated(postCustodianBankStatusEntity: entity));
    });
  }

  getCustodianBankStatus(GetCustodianBankStatusParams params) async {
    emit(LoadingState());
    final result = await getCustodianBankStatusUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(CustodianBankStateLoaded(custodianBankStatusEntity: entity));
    });
  }

  deleteCustodianBankStatus(DeleteCustodianBankStatusParams params) async {
    emit(LoadingState());
    final result = await deleteCustodianBankStatusUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }

  getStatuses() async {}
}
