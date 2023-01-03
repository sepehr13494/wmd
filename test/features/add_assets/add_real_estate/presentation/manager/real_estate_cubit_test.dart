import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

import 'real_estate_cubit_test.mocks.dart';

@GenerateMocks([AddRealEstateUseCase])
void main() {
  late MockAddRealEstateUseCase mockAddRealEstateUseCase;
  late RealEstateCubit realEstateCubit;
  setUp(() {
    mockAddRealEstateUseCase = MockAddRealEstateUseCase();
    realEstateCubit = RealEstateCubit(mockAddRealEstateUseCase);
  });

  blocTest(
    'when postRealEstate is emit the RealEstateSaved when success',
    build: () => realEstateCubit,
    setUp: () => when(mockAddRealEstateUseCase(any)).thenAnswer(
        (realInvocation) async => const Right(AddAssetModel.tAddAssetModel)),
    act: (bloc) async =>
        await bloc.postRealEstate(map: AddRealEstateParams.tAddRealEstateMap),
    expect: () => [
      isA<LoadingState>(),
      AddAssetState(addAsset: AddAssetModel.tAddAssetModel)
    ],
    verify: (_) {
      verify(mockAddRealEstateUseCase(AddRealEstateParams.tAddRealEstateMap))
          .called(1);
    },
  );
}
