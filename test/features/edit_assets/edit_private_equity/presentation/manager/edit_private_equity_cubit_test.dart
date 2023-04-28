    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/core/presentation/manager/edit_asset_state.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/delete_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/put_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/delete_private_equity_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/put_private_equity_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/presentation/manager/edit_private_equity_cubit.dart';

import 'edit_private_equity_cubit_test.mocks.dart';



@GenerateMocks([
  PutPrivateEquityUseCase,
  DeletePrivateEquityUseCase,

])
void main() {
  late MockPutPrivateEquityUseCase mockPutPrivateEquityUseCase;
  late MockDeletePrivateEquityUseCase mockDeletePrivateEquityUseCase;

  late EditPrivateEquityCubit editPrivateEquityCubit;


  setUp(() {
    mockPutPrivateEquityUseCase = MockPutPrivateEquityUseCase();
    mockDeletePrivateEquityUseCase = MockDeletePrivateEquityUseCase();

    editPrivateEquityCubit = EditPrivateEquityCubit(
    mockPutPrivateEquityUseCase,
    mockDeletePrivateEquityUseCase,

    );
  });
  

  group("putPrivateEquity", () {
    blocTest(
      'when PutPrivateEquityUseCase emits the PutPrivateEquityLoaded when success',
      build: () => editPrivateEquityCubit,
      setUp: () => when(mockPutPrivateEquityUseCase(any,any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async => await bloc.putPrivateEquity(map: PutPrivateEquityParams.tParams.addPrivateEquityParams.toJson(),assetId: PutPrivateEquityParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), EditAssetSuccess()],
      verify: (_) {
        verify(mockPutPrivateEquityUseCase(PutPrivateEquityParams.tParams.addPrivateEquityParams.toJson(),PutPrivateEquityParams.tParams.assetId));
      },
    );

    blocTest(
      'when PutPrivateEquityUseCase emits the ErrorState when error',
      build: () => editPrivateEquityCubit,
      setUp: () => when(mockPutPrivateEquityUseCase(any,any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.putPrivateEquity(map: PutPrivateEquityParams.tParams.addPrivateEquityParams.toJson(),assetId: PutPrivateEquityParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockPutPrivateEquityUseCase(PutPrivateEquityParams.tParams.addPrivateEquityParams.toJson(),PutPrivateEquityParams.tParams.assetId));
      },
    );
  });
  group("deletePrivateEquity", () {
    blocTest(
      'when DeletePrivateEquityUseCase emits the DeletePrivateEquityLoaded when success',
      build: () => editPrivateEquityCubit,
      setUp: () => when(mockDeletePrivateEquityUseCase(any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async => await bloc.deletePrivateEquity(assetId: DeletePrivateEquityParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), DeleteAssetSuccess()],
      verify: (_) {
        verify(mockDeletePrivateEquityUseCase(DeletePrivateEquityParams.tParams));
      },
    );

    blocTest(
      'when DeletePrivateEquityUseCase emits the ErrorState when error',
      build: () => editPrivateEquityCubit,
      setUp: () => when(mockDeletePrivateEquityUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.deletePrivateEquity(assetId: DeletePrivateEquityParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockDeletePrivateEquityUseCase(DeletePrivateEquityParams.tParams));
      },
    );
  });

}

    