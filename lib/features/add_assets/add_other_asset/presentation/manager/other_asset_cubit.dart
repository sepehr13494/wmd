import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

part 'other_asset_state.dart';

class OtherAssetCubit extends Cubit<OtherAssetState> {
  final AddOtherAssetUseCase addOtherAssetUseCase;

  OtherAssetCubit(this.addOtherAssetUseCase) : super(OtherAssetInitial());

  postOtherAsset({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await addOtherAssetUseCase(map);
    result.fold(
        (failure) => emit(ErrorState(failure: failure)),
        (realEstateSaveSuccess) =>
            emit(AddAssetState(addAsset: realEstateSaveSuccess)));
  }
}
