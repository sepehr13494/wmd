import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

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
        (realInvocation) async => const Right(AddAssetModel.tAddAssetModel)),
    act: (bloc) async =>
        await bloc.postBankDetails(map: BankSaveParams.tBankFormMap),
    expect: () => [
      isA<LoadingState>(),
      AddAssetState(addAsset: AddAssetModel.tAddAssetModel)
    ],
    verify: (_) {
      verify(mockPostBankDetailsUseCase(BankSaveParams.tBankFormMap)).called(1);
    },
  );
}
