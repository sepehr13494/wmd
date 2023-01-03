import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/add_assets/add_private_equity/presentation/manager/private_equity_cubit.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

import 'private_equity_cubit_test.mocks.dart';

@GenerateMocks([AddPrivateEquityUseCase])
void main() {
  late MockAddPrivateEquityUseCase mockAddPrivateEquityUseCase;
  late PrivateEquityCubit privateEquityCubit;
  setUp(() {
    mockAddPrivateEquityUseCase = MockAddPrivateEquityUseCase();
    privateEquityCubit = PrivateEquityCubit(mockAddPrivateEquityUseCase);
  });

  blocTest(
    'when postBankDetails is emit the BankDetailSaved when success',
    build: () => privateEquityCubit,
    setUp: () => when(mockAddPrivateEquityUseCase(any)).thenAnswer(
        (realInvocation) async => const Right(AddAssetModel.tAddAssetModel)),
    act: (bloc) async => await bloc.postPrivateEquity(
        map: AddPrivateEquityParams.tAddPrivateEquityMap),
    expect: () => [
      isA<LoadingState>(),
      AddAssetState(addAsset: AddAssetModel.tAddAssetModel)
    ],
    verify: (_) {
      verify(mockAddPrivateEquityUseCase(
              AddPrivateEquityParams.tAddPrivateEquityMap))
          .called(1);
    },
  );
}
