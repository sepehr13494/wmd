import 'package:bloc/bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/asset_detail/core/domain/entities/get_detail_entity.dart';

import '../../data/models/get_detail_params.dart';
import '../../domain/use_cases/get_detail_usecase.dart';

part 'asset_detail_state.dart';

class AssetDetailCubit extends Cubit<AssetDetailState> {
  final GetDetailUseCase getDetailUseCase;

  AssetDetailCubit(
    this.getDetailUseCase,
  ) : super(LoadingState());

  getDetail(GetDetailParams param) async {
    emit(LoadingState());
    final result = await getDetailUseCase(param);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entity) => emit(AssetLoaded(entity)));
  }
}
