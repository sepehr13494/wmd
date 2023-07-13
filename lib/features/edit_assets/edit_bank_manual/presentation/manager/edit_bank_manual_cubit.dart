import 'package:bloc/bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../../core/presentation/manager/edit_asset_state.dart';
import '../../domain/use_cases/put_bank_manual_usecase.dart';

import '../../data/models/delete_bank_manual_params.dart';
import '../../domain/use_cases/delete_bank_manual_usecase.dart';


class EditBankManualCubit extends Cubit<EditAssetBaseState> {

  final PutBankManualUseCase putBankManualUseCase;
  final DeleteBankManualUseCase deleteBankManualUseCase;


  EditBankManualCubit(
    this.putBankManualUseCase,
    this.deleteBankManualUseCase,
  ) : super(LoadingState());

  putBankManual({required Map<String, dynamic> map, required String assetId}) async {
    emit(LoadingState());
    final result = await putBankManualUseCase(map,assetId);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
          emit(EditAssetSuccess());
      
    });
  }
  
  deleteBankManual({required String assetId}) async {
    emit(LoadingState());
    final result = await deleteBankManualUseCase(DeleteBankManualParams(assetId: assetId));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
          emit(DeleteAssetSuccess());
      
    });
  }
  

}

    