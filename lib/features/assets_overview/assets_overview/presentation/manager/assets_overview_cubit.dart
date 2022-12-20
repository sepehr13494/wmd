import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../../domain/use_cases/get_assets_overview_usecase.dart';

part 'assets_overview_state.dart';

class AssetsOverviewCubit extends Cubit<AssetsOverviewState> {
  final GetAssetsOverviewUseCase assetsOverviewUseCase;
  AssetsOverviewCubit(this.assetsOverviewUseCase) : super(LoadingState());

  getAssetsOverview() async {
    emit(LoadingState());
    final result = await assetsOverviewUseCase(AssetsOverviewParams());
    result.fold(
            (failure) => emit(ErrorState(failure: failure)), (assetsOverviews) {
      emit(AssetsOverviewLoaded(assetsOverviews: assetsOverviews));
    });
  }
}