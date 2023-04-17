    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/use_cases/delete_bank_manual_usecase.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/use_cases/put_bank_manual_usecase.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/presentation/manager/edit_bank_manual_cubit.dart';

import 'edit_bank_manual_cubit_test.mocks.dart';



@GenerateMocks([
  PutBankManualUseCase,
  DeleteBankManualUseCase,

])
void main() {
  late MockPutBankManualUseCase mockPutBankManualUseCase;
  late MockDeleteBankManualUseCase mockDeleteBankManualUseCase;

  late EditBankManualCubit editBankManualCubit;


  setUp(() {
    mockPutBankManualUseCase = MockPutBankManualUseCase();
    mockDeleteBankManualUseCase = MockDeleteBankManualUseCase();

    editBankManualCubit = EditBankManualCubit(
    mockPutBankManualUseCase,
    mockDeleteBankManualUseCase,

    );
  });
  

  group("putBankManual", () {
    blocTest(
      'when PutBankManualUseCase emits the PutBankManualLoaded when success',
      build: () => editBankManualCubit,
      setUp: () => when(mockPutBankManualUseCase(any,any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.putBankManual(map: PutBankManualParams.tParams.bankSaveParams.toJson(),assetId: PutBankManualParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), SuccessState(appSuccess: AppSuccess.tAppSuccess)],
      verify: (_) {
        verify(mockPutBankManualUseCase(PutBankManualParams.tParams.bankSaveParams.toJson(),PutBankManualParams.tParams.assetId));
      },
    );

    blocTest(
      'when PutBankManualUseCase emits the ErrorState when error',
      build: () => editBankManualCubit,
      setUp: () => when(mockPutBankManualUseCase(any,any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.putBankManual(map: PutBankManualParams.tParams.bankSaveParams.toJson(),assetId: PutBankManualParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockPutBankManualUseCase(PutBankManualParams.tParams.bankSaveParams.toJson(),PutBankManualParams.tParams.assetId));
      },
    );
  });
  group("deleteBankManual", () {
    blocTest(
      'when DeleteBankManualUseCase emits the DeleteBankManualLoaded when success',
      build: () => editBankManualCubit,
      setUp: () => when(mockDeleteBankManualUseCase(any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.deleteBankManual(assetId: DeleteBankManualParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), SuccessState(appSuccess: AppSuccess.tAppSuccess)],
      verify: (_) {
        verify(mockDeleteBankManualUseCase(DeleteBankManualParams.tParams));
      },
    );

    blocTest(
      'when DeleteBankManualUseCase emits the ErrorState when error',
      build: () => editBankManualCubit,
      setUp: () => when(mockDeleteBankManualUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.deleteBankManual(assetId: DeleteBankManualParams.tParams.assetId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockDeleteBankManualUseCase(DeleteBankManualParams.tParams));
      },
    );
  });

}

    