import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/get_custodian_status_list_usecase.dart';
import '../../data/models/get_custodian_bank_list_params.dart';

part 'custodian_status_list_state.dart';

class CustodianStatusListCubit extends Cubit<CustodianStatusListState> {
  final GetCustodianStatusListUseCase getCustodianStatusListUseCase;

  CustodianStatusListCubit(
    this.getCustodianStatusListUseCase,
  ) : super(LoadingState());

  List<CustodianBankStatusEntity> statutes = [];

  getCustodianStatusList() async {
    emit(LoadingState());
    debugPrint("working.... cubit");
    final result =
        await getCustodianStatusListUseCase(GetCustodianBankListParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      debugPrint("success-----");
      debugPrint(entities.toString());
      statutes = List.from(entities);
      emit(StatusListLoaded(statusEntity: entities));
    });
  }
}
