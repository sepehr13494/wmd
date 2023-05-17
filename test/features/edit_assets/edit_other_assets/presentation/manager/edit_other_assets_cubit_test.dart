import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/delete_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/put_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/use_cases/delete_other_assets_usecase.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/use_cases/put_other_assets_usecase.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/presentation/manager/edit_other_assets_cubit.dart';

import 'edit_other_assets_cubit_test.mocks.dart';



@GenerateMocks([
  PutOtherAssetsUseCase,
  DeleteOtherAssetsUseCase,

])
void main() {
  late MockPutOtherAssetsUseCase mockPutOtherAssetsUseCase;
  late MockDeleteOtherAssetsUseCase mockDeleteOtherAssetsUseCase;

  late EditOtherAssetsCubit editOtherAssetsCubit;


  setUp(() {
    mockPutOtherAssetsUseCase = MockPutOtherAssetsUseCase();
    mockDeleteOtherAssetsUseCase = MockDeleteOtherAssetsUseCase();

    editOtherAssetsCubit = EditOtherAssetsCubit(
      mockPutOtherAssetsUseCase,
      mockDeleteOtherAssetsUseCase,

    );
  });


  group("putOtherAssets", () {
    blocTest(
      'when PutOtherAssetsUseCase emits the PutOtherAssetsLoaded when success',
      build: () => editOtherAssetsCubit,
      setUp: () => when(mockPutOtherAssetsUseCase(any,any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async => await bloc.putOtherAssets(map: PutOtherAssetsParams.tParams.addOtherAssetParams.toJson(),assetId: PutOtherAssetsParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), EditAssetSuccess()],
      verify: (_) {
        verify(mockPutOtherAssetsUseCase(PutOtherAssetsParams.tParams.addOtherAssetParams.toJson(),PutOtherAssetsParams.tParams.assetId));
      },
    );

    blocTest(
      'when PutOtherAssetsUseCase emits the ErrorState when error',
      build: () => editOtherAssetsCubit,
      setUp: () => when(mockPutOtherAssetsUseCase(any,any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.putOtherAssets(map: PutOtherAssetsParams.tParams.addOtherAssetParams.toJson(),assetId: PutOtherAssetsParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockPutOtherAssetsUseCase(PutOtherAssetsParams.tParams.addOtherAssetParams.toJson(),PutOtherAssetsParams.tParams.assetId));
      },
    );
  });
  group("deleteOtherAssets", () {
    blocTest(
      'when DeleteOtherAssetsUseCase emits the DeleteOtherAssetsLoaded when success',
      build: () => editOtherAssetsCubit,
      setUp: () => when(mockDeleteOtherAssetsUseCase(any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async => await bloc.deleteOtherAssets(assetId: DeleteOtherAssetsParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), DeleteAssetSuccess()],
      verify: (_) {
        verify(mockDeleteOtherAssetsUseCase(DeleteOtherAssetsParams.tParams));
      },
    );

    blocTest(
      'when DeleteOtherAssetsUseCase emits the ErrorState when error',
      build: () => editOtherAssetsCubit,
      setUp: () => when(mockDeleteOtherAssetsUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.deleteOtherAssets(assetId: DeleteOtherAssetsParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockDeleteOtherAssetsUseCase(DeleteOtherAssetsParams.tParams));
      },
    );
  });

}

    