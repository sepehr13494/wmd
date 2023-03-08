    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_params.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_response.dart';
import 'package:wmd/features/force_update/domain/use_cases/get_force_update_usecase.dart';
import 'package:wmd/features/force_update/presentation/manager/force_update_cubit.dart';

import 'force_update_cubit_test.mocks.dart';



@GenerateMocks([
  GetForceUpdateUseCase,

])
void main() {
  late MockGetForceUpdateUseCase mockGetForceUpdateUseCase;

  late ForceUpdateCubit forceUpdateCubit;


  setUp(() {
    mockGetForceUpdateUseCase = MockGetForceUpdateUseCase();

    forceUpdateCubit = ForceUpdateCubit(
    mockGetForceUpdateUseCase,

    );
  });
  

  group("getForceUpdate", () {
    blocTest(
      'when GetForceUpdateUseCase emits the GetForceUpdateLoaded when success',
      build: () => forceUpdateCubit,
      setUp: () => when(mockGetForceUpdateUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetForceUpdateResponse.tResponse)),
      act: (bloc) async => await bloc.getForceUpdate(),
      expect: () =>
      [isA<LoadingState>(), GetForceUpdateLoaded(getForceUpdateEntity : GetForceUpdateResponse.tResponse)],
      verify: (_) {
        verify(mockGetForceUpdateUseCase(NoParams()));
      },
    );

    blocTest(
      'when GetForceUpdateUseCase emits the ErrorState when error',
      build: () => forceUpdateCubit,
      setUp: () => when(mockGetForceUpdateUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getForceUpdate(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetForceUpdateUseCase(NoParams()));
      },
    );
  });

}

    