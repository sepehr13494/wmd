import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';

import '../../data/models/put_real_estate_params.dart';
import '../../domain/use_cases/put_real_estate_usecase.dart';

import '../../data/models/delete_real_estate_params.dart';
import '../../domain/use_cases/delete_real_estate_usecase.dart';




class EditRealEstateCubit extends Cubit<EditAssetBaseState> {

  final PutRealEstateUseCase putRealEstateUseCase;
  final DeleteRealEstateUseCase deleteRealEstateUseCase;


  EditRealEstateCubit(
    this.putRealEstateUseCase,
    this.deleteRealEstateUseCase,
  ) : super(LoadingState());

  putRealEstate({required Map<String, dynamic> map, required String assetId}) async {
    emit(LoadingState());
    final result = await putRealEstateUseCase(map,assetId);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(EditAssetSuccess());
      
    });
  }
  
  deleteRealEstate({required String assetId}) async {
    emit(LoadingState());
    final result = await deleteRealEstateUseCase(DeleteRealEstateParams(assetId: assetId));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(DeleteAssetSuccess());
    });
  }
  

}

    