import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../../core/presentation/manager/edit_asset_state.dart';
import '../../data/models/put_listed_asset_params.dart';
import '../../domain/use_cases/put_listed_asset_usecase.dart';

import '../../data/models/delete_listed_asset_params.dart';
import '../../domain/use_cases/delete_listed_asset_usecase.dart';


class EditListedAssetCubit extends Cubit<EditAssetBaseState> {

  final PutListedAssetUseCase putListedAssetUseCase;
  final DeleteListedAssetUseCase deleteListedAssetUseCase;


  EditListedAssetCubit(
    this.putListedAssetUseCase,
    this.deleteListedAssetUseCase,
  ) : super(LoadingState());

  putListedAsset({required Map<String, dynamic> map, required String assetId}) async {
    emit(LoadingState());
    final result = await putListedAssetUseCase(map,assetId);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(EditAssetSuccess());
      
    });
  }
  
  deleteListedAsset({required String assetId}) async {
    emit(LoadingState());
    final result = await deleteListedAssetUseCase(DeleteListedAssetParams(assetId: assetId));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(DeleteAssetSuccess());
      
    });
  }
  

}

    