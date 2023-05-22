import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_liablility_overview_params.dart';
import '../../domain/use_cases/get_liablility_overview_usecase.dart';
import '../../domain/entities/get_liablility_overview_entity.dart';

part 'liablility_overview_state.dart';

class LiabilityOverviewCubit extends Cubit<LiablilityOverviewState> {
  final GetLiabilityOverviewUseCase getLiablilityOverviewUseCase;

  LiabilityOverviewCubit(
    this.getLiablilityOverviewUseCase,
  ) : super(LoadingState());

  getLiablilityOverview() async {
    emit(LoadingState());
    final result =
        await getLiablilityOverviewUseCase(GetLiabilityOverviewParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(GetLiabilityOverviewLoaded(getLiablilityOverviewEntities: entities));
    });
  }
}
