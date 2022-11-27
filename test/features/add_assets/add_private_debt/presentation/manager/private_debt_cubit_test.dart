import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';
import 'package:wmd/features/add_assets/add_private_debt/presentation/manager/private_debt_cubit.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'private_debt_cubit_test.mocks.dart';

@GenerateMocks([AddPrivateDebtUseCase])
void main() {
  late MockAddPrivateDebtUseCase mockAddPrivateDebtUseCase;
  late PrivateDebtCubit privateDebtCubit;
  setUp(() {
    mockAddPrivateDebtUseCase = MockAddPrivateDebtUseCase();
    privateDebtCubit = PrivateDebtCubit(mockAddPrivateDebtUseCase);
  });

  blocTest(
    'when postPrivateDebt is emit the PrivateDebtSaved when success',
    build: () => privateDebtCubit,
    setUp: () => when(mockAddPrivateDebtUseCase(any)).thenAnswer(
        (realInvocation) async => const Right(AddAssetModel.tAddAssetModel)),
    act: (bloc) async => await bloc.postPrivateDebt(
        map: AddPrivateDebtParams.tAddPrivateDebtMap),
    expect: () => [
      isA<LoadingState>(),
      PrivateDebtSaved(privateDebtSaveResponse: AddAssetModel.tAddAssetModel)
    ],
    verify: (_) {
      verify(mockAddPrivateDebtUseCase(AddPrivateDebtParams.tAddPrivateDebtMap))
          .called(1);
    },
  );
}
