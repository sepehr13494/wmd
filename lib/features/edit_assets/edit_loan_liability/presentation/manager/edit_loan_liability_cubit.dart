import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';

import '../../data/models/put_loan_liability_params.dart';
import '../../domain/use_cases/put_loan_liability_usecase.dart';

import '../../data/models/delete_loan_liability_params.dart';
import '../../domain/use_cases/delete_loan_liability_usecase.dart';



part 'edit_loan_liability_state.dart';

class EditLoanLiabilityCubit extends Cubit<EditAssetBaseState> {

  final PutLoanLiabilityUseCase putLoanLiabilityUseCase;
  final DeleteLoanLiabilityUseCase deleteLoanLiabilityUseCase;


  EditLoanLiabilityCubit(
    this.putLoanLiabilityUseCase,
    this.deleteLoanLiabilityUseCase,
  ) : super(LoadingState());

  putLoanLiability({required Map<String, dynamic> map, required String assetId}) async {
    emit(LoadingState());
    final result = await putLoanLiabilityUseCase(map,assetId);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(EditAssetSuccess());
      
    });
  }
  
  deleteLoanLiability({required String assetId}) async {
    emit(LoadingState());
    final result = await deleteLoanLiabilityUseCase(DeleteLoanLiabilityParams(assetId: assetId));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(DeleteAssetSuccess());
      
    });
  }
  

}

    