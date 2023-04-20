import 'package:bloc/bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../../core/presentation/manager/edit_asset_state.dart';
import '../../domain/use_cases/put_other_assets_usecase.dart';

import '../../data/models/delete_other_assets_params.dart';
import '../../domain/use_cases/delete_other_assets_usecase.dart';




class EditOtherAssetsCubit extends Cubit<EditAssetBaseState> {

  final PutOtherAssetsUseCase putOtherAssetsUseCase;
  final DeleteOtherAssetsUseCase deleteOtherAssetsUseCase;


  EditOtherAssetsCubit(
    this.putOtherAssetsUseCase,
    this.deleteOtherAssetsUseCase,
  ) : super(LoadingState());

  putOtherAssets({required Map<String, dynamic> map, required String assetId}) async {
    emit(LoadingState());
    final result = await putOtherAssetsUseCase(map,assetId);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(EditAssetSuccess());
      
    });
  }
  
  deleteOtherAssets({required String assetId}) async {
    emit(LoadingState());
    final result = await deleteOtherAssetsUseCase(DeleteOtherAssetsParams(assetId: assetId));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(DeleteAssetSuccess());
      
    });
  }
  

}

    