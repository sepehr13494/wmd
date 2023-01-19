import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';

import '../../data/models/get_asset_see_more_params.dart';
import '../../domain/use_cases/get_asset_see_more_usecase.dart';

part 'asset_see_more_state.dart';

class AssetSeeMoreCubit extends Cubit<AssetSeeMoreState> {
  final GetSeeMoreUseCase getAssetSeeMoreUseCase;

  AssetSeeMoreCubit(
    this.getAssetSeeMoreUseCase,
  ) : super(LoadingState());

  getAssetSeeMore(GetSeeMoreParams params) async {
    emit(LoadingState());
    final result = await getAssetSeeMoreUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(GetSeeMoreLoaded(getAssetSeeMoreEntity: entity));
    });
  }
}
