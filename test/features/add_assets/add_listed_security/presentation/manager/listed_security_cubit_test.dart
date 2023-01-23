import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/get_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/add_listed_security/presentation/manager/listed_security_cubit.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';
import 'package:wmd/features/add_assets/core/presentation/bloc/add_asset_base_state.dart';

import 'listed_security_cubit_test.mocks.dart';

@GenerateMocks([AddListedSecurityUseCase, GetListedSecurityUseCase])
void main() {
  late MockAddListedSecurityUseCase mockAddListedSecurityUseCase;
  late MockGetListedSecurityUseCase mockGetListedSecurityUseCase;
  late ListedSecurityCubit listedSecurityCubit;
  setUp(() {
    mockAddListedSecurityUseCase = MockAddListedSecurityUseCase();
    mockGetListedSecurityUseCase = MockGetListedSecurityUseCase();
    listedSecurityCubit = ListedSecurityCubit(
        mockAddListedSecurityUseCase, mockGetListedSecurityUseCase);
  });

  blocTest(
    'when postListedSecurity is emit the ListedSecuritySaved when success',
    build: () => listedSecurityCubit,
    setUp: () => when(mockAddListedSecurityUseCase(any)).thenAnswer(
        (realInvocation) async => const Right(AddAssetModel.tAddAssetModel)),
    act: (bloc) async => await bloc.postListedSecurity(
        map: AddListedSecurityParams.tAddListedSecurityMap),
    expect: () => [
      isA<LoadingState>(),
      AddAssetState(addAsset: AddAssetModel.tAddAssetModel)
    ],
    verify: (_) {
      verify(mockAddListedSecurityUseCase(
              AddListedSecurityParams.tAddListedSecurityMap))
          .called(1);
    },
  );
}
