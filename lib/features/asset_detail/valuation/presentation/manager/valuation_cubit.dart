import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/valuation/domain/use_cases/get_all_transaction_usecase.dart';

import '../../data/models/get_all_valuation_params.dart';
import '../../domain/use_cases/get_all_valuation_usecase.dart';
import '../../domain/entities/get_all_valuation_entity.dart';
import '../../data/models/post_valuation_params.dart';
import '../../domain/use_cases/post_valuation_usecase.dart';

import '../../data/models/get_valuation_performance_params.dart';
import '../../domain/use_cases/get_valuation_performance_usecase.dart';
import '../../domain/entities/valuation_history_entity.dart';

part 'valuation_state.dart';

class ValuationCubit extends Cubit<ValuationState> {
  final GetAllValuationUseCase getAllValuationUseCase;
  final GetAllTransactionUseCase getAllTransactionUseCase;
  final PostValuationUseCase postValuationUseCase;

  ValuationCubit(
    this.getAllValuationUseCase,
    this.postValuationUseCase,
    this.getAllTransactionUseCase,
  ) : super(LoadingState());

  // getAllValuation(GetAllValuationParams params) async {
  //   emit(LoadingState());
  //   final result = await getAllValuationUseCase(params);
  //   result.fold((failure) => emit(ErrorState(failure: failure)),
  //       (List<GetAllValuationEntity> entities) {
  //     emit(GetAllValuationLoaded(getAllValuationEntities: entities));
  //   });
  // }

  // getAllTransactions(GetAllValuationParams params) async {
  //   emit(LoadingState());
  //   final result = await getAllTransactionUseCase(params);
  //   result.fold((failure) => emit(ErrorState(failure: failure)),
  //       (List<GetAllValuationEntity> entities) {
  //     emit(GetAllTransactionLoaded(getAllTransactionEntities: entities));
  //   });
  // }

  getAllTransactionValuation(GetAllValuationParams params) async {
    List<GetAllValuationEntity> resultTransactionList = [];
    List<GetAllValuationEntity> resultValuationsList = [];

    emit(LoadingState());
    final resultTransaction = await getAllTransactionUseCase(params);
    resultTransaction.fold((failure) => emit(ErrorState(failure: failure)),
        (List<GetAllValuationEntity> entities) {
      resultTransactionList = entities;
    });

    if ([
      AssetTypes.privateDebt,
      AssetTypes.privateEquity,
      AssetTypes.realEstate,
      AssetTypes.otherAsset,
      AssetTypes.otherAssets,
    ].contains(params.type)) {
      final resultValuations = await getAllValuationUseCase(params);
      resultValuations.fold((failure) => emit(ErrorState(failure: failure)),
          (List<GetAllValuationEntity> entities) {
        resultValuationsList = entities;
      });
    }

    emit(GetAllValuationLoaded(
        getAllTransactionEntities: resultTransactionList,
        getAllValuationEntities: resultValuationsList));
  }

  postValuation() async {
    emit(LoadingState());
    final result = await postValuationUseCase(PostValuationParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }
}
