import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/safe_device/data/models/is_safe_device_params.dart';
import 'package:wmd/features/safe_device/domain/use_cases/is_safe_device_usecase.dart';

import '../../data/repositories/safe_device_repository_impl_test.mocks.dart';

void main() {
  late IsSafeDeviceUseCase isSafeDeviceUseCase;
  late MockSafeDeviceRepository mockSafeDeviceRepository;

  setUp(() {
    mockSafeDeviceRepository = MockSafeDeviceRepository();
    isSafeDeviceUseCase = IsSafeDeviceUseCase(mockSafeDeviceRepository);
  });

  test('should get IsSafeDeviceEntity from the repository', () async {
    //arrange
    when(mockSafeDeviceRepository.isSafeDevice(any)).thenAnswer(
        (_) async => const Right(AppSuccess(message: "successfully done")));
    // act
    final result = await isSafeDeviceUseCase(IsSafeDeviceParams.tParams);

    // assert
    expect(result, equals(const Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockSafeDeviceRepository.isSafeDevice(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await isSafeDeviceUseCase(IsSafeDeviceParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockSafeDeviceRepository.isSafeDevice(IsSafeDeviceParams.tParams));
    },
  );
}
