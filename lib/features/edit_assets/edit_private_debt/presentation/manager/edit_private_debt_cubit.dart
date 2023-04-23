import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../../core/presentation/manager/edit_asset_state.dart';
import '../../data/models/put_private_debt_params.dart';
import '../../domain/use_cases/put_private_debt_usecase.dart';

import '../../data/models/delete_private_debt_params.dart';
import '../../domain/use_cases/delete_private_debt_usecase.dart';


class EditPrivateDebtCubit extends Cubit<EditAssetBaseState> {

  final PutPrivateDebtUseCase putPrivateDebtUseCase;
  final DeletePrivateDebtUseCase deletePrivateDebtUseCase;


  EditPrivateDebtCubit(
    this.putPrivateDebtUseCase,
    this.deletePrivateDebtUseCase,
  ) : super(LoadingState());

  putPrivateDebt({required Map<String, dynamic> map, required String assetId}) async {
    emit(LoadingState());
    final result = await putPrivateDebtUseCase(map,assetId);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(EditAssetSuccess());
      
    });
  }
  
  deletePrivateDebt({required String assetId}) async {
    emit(LoadingState());
    final result = await deletePrivateDebtUseCase(DeletePrivateDebtParams(assetId: assetId));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(DeleteAssetSuccess());
      
    });
  }
  

}

    