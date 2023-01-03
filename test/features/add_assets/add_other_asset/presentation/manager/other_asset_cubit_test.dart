import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/add_other_asset/presentation/manager/other_asset_cubit.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

import 'other_asset_cubit_test.mocks.dart';

@GenerateMocks([AddOtherAssetUseCase])
void main() {
  late MockAddOtherAssetUseCase mockAddOtherAssetUseCase;
  late OtherAssetCubit otherAssetCubit;
  setUp(() {
    mockAddOtherAssetUseCase = MockAddOtherAssetUseCase();
    otherAssetCubit = OtherAssetCubit(mockAddOtherAssetUseCase);
  });

  blocTest(
    'when postRealEstate is emit the RealEstateSaved when success',
    build: () => otherAssetCubit,
    setUp: () => when(mockAddOtherAssetUseCase(any)).thenAnswer(
        (realInvocation) async => const Right(AddAssetModel.tAddAssetModel)),
    act: (bloc) async =>
        await bloc.postOtherAsset(map: AddOtherAssetParams.tAddOtherAssetMap),
    expect: () => [
      isA<LoadingState>(),
      AddAssetState(addAsset: AddAssetModel.tAddAssetModel)
    ],
    verify: (_) {
      verify(mockAddOtherAssetUseCase(AddOtherAssetParams.tAddOtherAssetMap))
          .called(1);
    },
  );
}
