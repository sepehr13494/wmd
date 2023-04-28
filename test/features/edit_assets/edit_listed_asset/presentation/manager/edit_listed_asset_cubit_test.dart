    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/delete_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/put_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/use_cases/delete_listed_asset_usecase.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/use_cases/put_listed_asset_usecase.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/presentation/manager/edit_listed_asset_cubit.dart';

import 'edit_listed_asset_cubit_test.mocks.dart';



@GenerateMocks([
  PutListedAssetUseCase,
  DeleteListedAssetUseCase,

])
void main() {
  late MockPutListedAssetUseCase mockPutListedAssetUseCase;
  late MockDeleteListedAssetUseCase mockDeleteListedAssetUseCase;

  late EditListedAssetCubit editListedAssetCubit;


  setUp(() {
    mockPutListedAssetUseCase = MockPutListedAssetUseCase();
    mockDeleteListedAssetUseCase = MockDeleteListedAssetUseCase();

    editListedAssetCubit = EditListedAssetCubit(
    mockPutListedAssetUseCase,
    mockDeleteListedAssetUseCase,

    );
  });
  

  group("putListedAsset", () {
    blocTest(
      'when PutListedAssetUseCase emits the PutListedAssetLoaded when success',
      build: () => editListedAssetCubit,
      setUp: () => when(mockPutListedAssetUseCase(any,any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async => await bloc.putListedAsset(map: PutListedAssetParams.tParams.addListedSecurityParams.toJson(),assetId: PutListedAssetParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), EditAssetSuccess()],
      verify: (_) {
        verify(mockPutListedAssetUseCase(PutListedAssetParams.tParams.addListedSecurityParams.toJson(),PutListedAssetParams.tParams.assetId));
      },
    );

    blocTest(
      'when PutListedAssetUseCase emits the ErrorState when error',
      build: () => editListedAssetCubit,
      setUp: () => when(mockPutListedAssetUseCase(any,any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.putListedAsset(map: PutListedAssetParams.tParams.addListedSecurityParams.toJson(),assetId: PutListedAssetParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockPutListedAssetUseCase(PutListedAssetParams.tParams.addListedSecurityParams.toJson(), PutListedAssetParams.tParams.assetId));
      },
    );
  });
  group("deleteListedAsset", () {
    blocTest(
      'when DeleteListedAssetUseCase emits the DeleteListedAssetLoaded when success',
      build: () => editListedAssetCubit,
      setUp: () => when(mockDeleteListedAssetUseCase(any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async => await bloc.deleteListedAsset(assetId: PutListedAssetParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), DeleteAssetSuccess()],
      verify: (_) {
        verify(mockDeleteListedAssetUseCase(DeleteListedAssetParams.tParams));
      },
    );

    blocTest(
      'when DeleteListedAssetUseCase emits the ErrorState when error',
      build: () => editListedAssetCubit,
      setUp: () => when(mockDeleteListedAssetUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.deleteListedAsset(assetId: PutListedAssetParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockDeleteListedAssetUseCase(DeleteListedAssetParams.tParams));
      },
    );
  });

}

    