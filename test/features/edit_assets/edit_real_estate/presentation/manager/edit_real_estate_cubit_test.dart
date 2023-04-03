    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/delete_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/put_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/use_cases/delete_real_estate_usecase.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/use_cases/put_real_estate_usecase.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/presentation/manager/edit_real_estate_cubit.dart';

import 'edit_real_estate_cubit_test.mocks.dart';



@GenerateMocks([
  PutRealEstateUseCase,
  DeleteRealEstateUseCase,

])
void main() {
  late MockPutRealEstateUseCase mockPutRealEstateUseCase;
  late MockDeleteRealEstateUseCase mockDeleteRealEstateUseCase;

  late EditRealEstateCubit editRealEstateCubit;


  setUp(() {
    mockPutRealEstateUseCase = MockPutRealEstateUseCase();
    mockDeleteRealEstateUseCase = MockDeleteRealEstateUseCase();

    editRealEstateCubit = EditRealEstateCubit(
    mockPutRealEstateUseCase,
    mockDeleteRealEstateUseCase,

    );
  });
  

  group("putRealEstate", () {
    blocTest(
      'when PutRealEstateUseCase emits the PutRealEstateLoaded when success',
      build: () => editRealEstateCubit,
      setUp: () => when(mockPutRealEstateUseCase(any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.putRealEstate(),
      expect: () =>
      [isA<LoadingState>(), SuccessState(appSuccess: AppSuccess.tAppSuccess)],
      verify: (_) {
        verify(mockPutRealEstateUseCase(PutRealEstateParams.tParams));
      },
    );

    blocTest(
      'when PutRealEstateUseCase emits the ErrorState when error',
      build: () => editRealEstateCubit,
      setUp: () => when(mockPutRealEstateUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.putRealEstate(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockPutRealEstateUseCase(PutRealEstateParams.tParams));
      },
    );

  });
  group("deleteRealEstate", () {
    blocTest(
      'when PutRealEstateUseCase emits the PutRealEstateLoaded when success',
      build: () => editRealEstateCubit,
      setUp: () => when(mockPutRealEstateUseCase(any))
          .thenAnswer((realInvocation) async => const Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.putRealEstate(),
      expect: () =>
      [isA<LoadingState>(), SuccessState(appSuccess: AppSuccess.tAppSuccess)],
      verify: (_) {
        verify(mockPutRealEstateUseCase(PutRealEstateParams.tParams));
      },
    );

    blocTest(
      'when DeleteRealEstateUseCase emits the ErrorState when error',
      build: () => editRealEstateCubit,
      setUp: () => when(mockDeleteRealEstateUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.deleteRealEstate(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockDeleteRealEstateUseCase(DeleteRealEstateParams.tParams));
      },
    );
  });

}

    