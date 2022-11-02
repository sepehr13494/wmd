import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';

import 'bank_cubit_test.mocks.dart';

@GenerateMocks([PostBankDetailsUseCase])
void main() {
  late MockPostBankDetailsUseCase mockPostBankDetailsUseCase;
  late BankCubit bankCubit;

  setUp(() {
    mockPostBankDetailsUseCase = MockPostBankDetailsUseCase();
    bankCubit = BankCubit(mockPostBankDetailsUseCase);
  });

  blocTest(
    'when postBankDetails is emit the BankDetailSaved when success',
    build: () => bankCubit,
    setUp: () => when(mockPostBankDetailsUseCase(any)).thenAnswer(
        (realInvocation) async =>
            const Right(BankSaveResponseModel.tBankSaveResponseModel)),
    act: (bloc) async => await bloc.postBankDetails(
        map: BankSaveParams.tBankSaveParams.toJson()),
    expect: () => [
      isA<LoadingState>(),
      BankDetailSaved(
          bankSaveResponse: BankSaveResponseModel.tBankSaveResponseModel)
    ],
    verify: (_) {
      verify(mockPostBankDetailsUseCase(BankSaveParams.tBankSaveParams))
          .called(1);
    },
  );
}
