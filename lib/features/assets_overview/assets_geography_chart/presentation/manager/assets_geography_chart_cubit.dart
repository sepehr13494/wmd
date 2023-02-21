import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_assets_geography_params.dart';
import '../../domain/use_cases/get_assets_geography_usecase.dart';
import '../../domain/entities/get_assets_geography_entity.dart';


part 'assets_geography_chart_state.dart';

class AssetsGeographyChartCubit extends Cubit<AssetsGeographyChartState> {

  final GetAssetsGeographyUseCase getAssetsGeographyUseCase;


  AssetsGeographyChartCubit(
    this.getAssetsGeographyUseCase,
  ) : super(LoadingState());

  getAssetsGeography() async {
    emit(LoadingState());
    final result = await getAssetsGeographyUseCase(GetAssetsGeographyParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetAssetsGeographyLoaded(getAssetsGeographyEntities: entities));
    });
  }
  

}

    