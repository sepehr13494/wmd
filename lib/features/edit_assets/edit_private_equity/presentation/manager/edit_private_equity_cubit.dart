import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../../core/presentation/manager/edit_asset_state.dart';
import '../../data/models/put_private_equity_params.dart';
import '../../domain/use_cases/put_private_equity_usecase.dart';

import '../../data/models/delete_private_equity_params.dart';
import '../../domain/use_cases/delete_private_equity_usecase.dart';


class EditPrivateEquityCubit extends Cubit<EditAssetBaseState> {

  final PutPrivateEquityUseCase putPrivateEquityUseCase;
  final DeletePrivateEquityUseCase deletePrivateEquityUseCase;


  EditPrivateEquityCubit(
    this.putPrivateEquityUseCase,
    this.deletePrivateEquityUseCase,
  ) : super(LoadingState());

  putPrivateEquity({required Map<String, dynamic> map, required String assetId}) async {
    emit(LoadingState());
    final result = await putPrivateEquityUseCase(map,assetId);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(EditAssetSuccess());
      
    });
  }
  
  deletePrivateEquity({required String assetId}) async {
    emit(LoadingState());
    final result = await deletePrivateEquityUseCase(DeletePrivateEquityParams(assetId: assetId));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(DeleteAssetSuccess());
      
    });
  }
  

}

    