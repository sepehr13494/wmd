import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/safe_device/data/models/is_safe_device_params.dart';
import 'package:wmd/features/safe_device/domain/entities/is_safe_device_entity.dart';
import 'package:wmd/features/safe_device/domain/use_cases/is_safe_device_usecase.dart';
import 'package:wmd/features/safe_device/presentation/manager/safe_device_cubit.dart';

import 'safe_device_cubit_test.mocks.dart';

@GenerateMocks([
  IsSafeDeviceUseCase,
])
void main() {
  late MockIsSafeDeviceUseCase mockIsSafeDeviceUseCase;

  late SafeDeviceCubit safeDeviceCubit;

  setUp(() {
    mockIsSafeDeviceUseCase = MockIsSafeDeviceUseCase();

    safeDeviceCubit = SafeDeviceCubit(
      mockIsSafeDeviceUseCase,
    );
  });

  group("isSafeDevice", () {
    blocTest(
      'when IsSafeDeviceUseCase emits the IsSafeDeviceLoaded when success',
      build: () => safeDeviceCubit,
      setUp: () => when(mockIsSafeDeviceUseCase(any)).thenAnswer(
          (realInvocation) async =>
              const Right(IsSafeDeviceEntity(true))),
      act: (bloc) async => await bloc.isSafeDevice(),
      expect: () => [
        isA<LoadingState>(),
        SuccessState(appSuccess: AppSuccess.tAppSuccess)
      ],
      verify: (_) {
        verify(mockIsSafeDeviceUseCase(IsSafeDeviceParams.tParams));
      },
    );

    blocTest(
      'when IsSafeDeviceUseCase emits the ErrorState when error',
      build: () => safeDeviceCubit,
      setUp: () => when(mockIsSafeDeviceUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.isSafeDevice(),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockIsSafeDeviceUseCase(IsSafeDeviceParams.tParams));
      },
    );
  });
}
