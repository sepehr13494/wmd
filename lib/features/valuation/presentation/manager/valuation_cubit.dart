import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_params.dart';
import 'package:wmd/features/valuation/domain/entities/get_valuation_entity.dart';
import 'package:wmd/features/valuation/domain/use_cases/delete_transaction_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/delete_valuation_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/get_transaction_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/get_valuation_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/post_transaction_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/post_valuation_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/update_transaction_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/update_valuation_usecase.dart';

import '../../data/models/post_valuation_params.dart';
import '../../domain/entities/post_valuation_entity.dart';
import '../../data/models/update_valuation_params.dart';
import '../../domain/entities/update_valuation_entity.dart';

part 'valuation_state.dart';

class AssetValuationCubit extends Cubit<AssetValuationState> {
  final AssetPostTransactionUseCase postTransactionUseCase;
  final UpdateTransactionUseCase updateTransactionUseCase;
  final AssetDeleteTransactionUseCase assetDeleteTransactionUseCase;
  final AssetGetTransactionUseCase assetGetTransactionUseCase;

  final AssetPostValuationUseCase assetPostValuationUseCase;
  final UpdateValuationUseCase updateValuationUseCase;
  final AssetGetValuationUseCase assetGetValuationUseCase;
  final AssetDeleteValuationUseCase assetDeleteValuationUseCase;

  AssetValuationCubit(
    this.postTransactionUseCase,
    this.updateTransactionUseCase,
    this.assetDeleteTransactionUseCase,
    this.assetGetTransactionUseCase,
    this.assetPostValuationUseCase,
    this.updateValuationUseCase,
    this.assetGetValuationUseCase,
    this.assetDeleteValuationUseCase,
  ) : super(LoadingState());

  postTransaction({required Map<String, dynamic> map}) async {
    emit(PostValuationLoadingState());
    final result =
        await postTransactionUseCase(PostValuationParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }

  postAssetValuation({required Map<String, dynamic> map}) async {
    emit(PostValuationLoadingState());
    final result =
        await assetPostValuationUseCase(PostValuationParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }

  updateTransaction({required Map<String, dynamic> map}) async {
    emit(PostValuationLoadingState());
    final result =
        await updateTransactionUseCase(UpdateValuationParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }

  updateValuation({required Map<String, dynamic> map}) async {
    emit(PostValuationLoadingState());
    final result =
        await updateValuationUseCase(UpdateValuationParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }

  deleteTransaction({required Map<String, dynamic> map}) async {
    emit(DeleteValuationLoadingState());
    final result =
        await assetDeleteTransactionUseCase(GetValuationParams.fromJson(map));

    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }

  deleteValuation({required Map<String, dynamic> map}) async {
    emit(DeleteValuationLoadingState());
    final result =
        await assetDeleteValuationUseCase(GetValuationParams.fromJson(map));

    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }

  getTransactionById({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result =
        await assetGetTransactionUseCase(GetValuationParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(GetValuationLoaded(entity: entity));
    });
  }

  getValuationById({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result =
        await assetGetValuationUseCase(GetValuationParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(GetValuationLoaded(entity: entity));
    });
  }
}
