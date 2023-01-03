import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

part 'loan_liability_state.dart';

class LoanLiabilityCubit extends Cubit<LoanLiabilityState> {
  final AddLoanLiabilityUseCase addLoanLiabilityUseCase;

  LoanLiabilityCubit(this.addLoanLiabilityUseCase)
      : super(LoanLiabilityInitial());

  postLoanLiability({required Map<String, dynamic> map}) async {
    print(map);
    emit(LoadingState());
    final result = await addLoanLiabilityUseCase(map);
    result.fold(
        (failure) => emit(ErrorState(failure: failure)),
        (realEstateSaveSuccess) =>
            emit(AddAssetState(addAsset: realEstateSaveSuccess)));
  }
}
