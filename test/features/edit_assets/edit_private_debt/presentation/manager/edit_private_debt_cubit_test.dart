    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/delete_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/put_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/use_cases/delete_private_debt_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/use_cases/put_private_debt_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/presentation/manager/edit_private_debt_cubit.dart';

import 'edit_private_debt_cubit_test.mocks.dart';



@GenerateMocks([
  PutPrivateDebtUseCase,
  DeletePrivateDebtUseCase,

])
void main() {
  late MockPutPrivateDebtUseCase mockPutPrivateDebtUseCase;
  late MockDeletePrivateDebtUseCase mockDeletePrivateDebtUseCase;

  late EditPrivateDebtCubit editPrivateDebtCubit;


  setUp(() {
    mockPutPrivateDebtUseCase = MockPutPrivateDebtUseCase();
    mockDeletePrivateDebtUseCase = MockDeletePrivateDebtUseCase();

    editPrivateDebtCubit = EditPrivateDebtCubit(
    mockPutPrivateDebtUseCase,
    mockDeletePrivateDebtUseCase,

    );
  });
  

  group("putPrivateDebt", () {
    blocTest(
      'when PutPrivateDebtUseCase emits the PutPrivateDebtLoaded when success',
      build: () => editPrivateDebtCubit,
      setUp: () => when(mockPutPrivateDebtUseCase(any,any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.putPrivateDebt(map: PutPrivateDebtParams.tParams.addPrivateDebtParams.toJson(),assetId: PutPrivateDebtParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), EditAssetSuccess()],
      verify: (_) {
        verify(mockPutPrivateDebtUseCase(PutPrivateDebtParams.tParams.addPrivateDebtParams.toJson(),PutPrivateDebtParams.tParams.assetId));
      },
    );

    blocTest(
      'when PutPrivateDebtUseCase emits the ErrorState when error',
      build: () => editPrivateDebtCubit,
      setUp: () => when(mockPutPrivateDebtUseCase(any,any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.putPrivateDebt(map: PutPrivateDebtParams.tParams.addPrivateDebtParams.toJson(),assetId: PutPrivateDebtParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockPutPrivateDebtUseCase(PutPrivateDebtParams.tParams.addPrivateDebtParams.toJson(),PutPrivateDebtParams.tParams.assetId));
      },
    );
  });
  group("deletePrivateDebt", () {
    blocTest(
      'when DeletePrivateDebtUseCase emits the DeletePrivateDebtLoaded when success',
      build: () => editPrivateDebtCubit,
      setUp: () => when(mockDeletePrivateDebtUseCase(any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.deletePrivateDebt(assetId: PutPrivateDebtParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), DeleteAssetSuccess()],
      verify: (_) {
        verify(mockDeletePrivateDebtUseCase(DeletePrivateDebtParams.tParams));
      },
    );

    blocTest(
      'when DeletePrivateDebtUseCase emits the ErrorState when error',
      build: () => editPrivateDebtCubit,
      setUp: () => when(mockDeletePrivateDebtUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.deletePrivateDebt(assetId: PutPrivateDebtParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockDeletePrivateDebtUseCase(DeletePrivateDebtParams.tParams));
      },
    );
  });

}

    