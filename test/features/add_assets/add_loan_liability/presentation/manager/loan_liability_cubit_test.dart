import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/add_loan_liability/presentation/manager/loan_liability_cubit.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

import 'loan_liability_cubit_test.mocks.dart';

@GenerateMocks([AddLoanLiabilityUseCase])
void main() {
  late MockAddLoanLiabilityUseCase mockAddLoanLiabilityUseCase;
  late LoanLiabilityCubit loanLiabilityCubit;
  setUp(() {
    mockAddLoanLiabilityUseCase = MockAddLoanLiabilityUseCase();
    loanLiabilityCubit = LoanLiabilityCubit(mockAddLoanLiabilityUseCase);
  });

  blocTest(
    'when postLoanLiability is emit the LoanLiabilitySaved when success',
    build: () => loanLiabilityCubit,
    setUp: () => when(mockAddLoanLiabilityUseCase(any)).thenAnswer(
        (realInvocation) async => const Right(AddAssetModel.tAddAssetModel)),
    act: (bloc) async => await bloc.postLoanLiability(
        map: AddLoanLiabilityParams.tAddLoanLiabilityMap),
    expect: () => [
      isA<LoadingState>(),
      AddAssetState(addAsset: AddAssetModel.tAddAssetModel)
    ],
    verify: (_) {
      verify(mockAddLoanLiabilityUseCase(
              AddLoanLiabilityParams.tAddLoanLiabilityMap))
          .called(1);
    },
  );
}
