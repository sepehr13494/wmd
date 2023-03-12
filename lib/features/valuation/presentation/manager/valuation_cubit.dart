import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/post_valuation_params.dart';
import '../../domain/use_cases/post_valuation_usecase.dart';
import '../../domain/entities/post_valuation_entity.dart';
import '../../data/models/update_valuation_params.dart';
import '../../domain/use_cases/update_valuation_usecase.dart';
import '../../domain/entities/update_valuation_entity.dart';

part 'valuation_state.dart';

class AssetValuationCubit extends Cubit<AssetValuationState> {
  final PostValuationUseCase postValuationUseCase;
  final UpdateValuationUseCase updateValuationUseCase;

  AssetValuationCubit(
    this.postValuationUseCase,
    this.updateValuationUseCase,
  ) : super(LoadingState());

  postValuation() async {
    emit(LoadingState());
    final result = await postValuationUseCase(PostValuationParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(PostValuationLoaded(postValuationEntity: entity));
    });
  }

  updateValuation() async {
    emit(LoadingState());
    final result = await updateValuationUseCase(UpdateValuationParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(UpdateValuationLoaded(updateValuationEntity: entity));
    });
  }
}
