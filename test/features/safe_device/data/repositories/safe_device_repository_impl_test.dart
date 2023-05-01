import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/safe_device/data/data_sources/safe_device_local_datasource.dart';
import 'package:wmd/features/safe_device/data/models/is_safe_device_params.dart';
import 'package:wmd/features/safe_device/data/models/is_safe_device_response.dart';
import 'package:wmd/features/safe_device/data/repositories/safe_device_repository_impl.dart';
import 'package:wmd/features/safe_device/domain/repositories/safe_device_repository.dart';

import 'safe_device_repository_impl_test.mocks.dart';

@GenerateMocks([SafeDeviceLocalDataSource, SafeDeviceRepository])
void main() {
  late MockSafeDeviceLocalDataSource remoteDataSource;
  late SafeDeviceRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockSafeDeviceLocalDataSource();
    repositoryImpl = SafeDeviceRepositoryImpl(remoteDataSource);
  });

  group('IsSafeDevice', () {
    test(
      'should return IsSafeDeviceResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.isSafeDevice(any))
            .thenAnswer((_) async => IsSafeDeviceResponse.tResponse);
        // act
        final result =
            await repositoryImpl.isSafeDevice(IsSafeDeviceParams.tParams);
        // assert
        expect(result, equals(const Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.isSafeDevice(IsSafeDeviceParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.isSafeDevice(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result =
            await repositoryImpl.isSafeDevice(IsSafeDeviceParams.tParams);
        // assert
        verify(remoteDataSource.isSafeDevice(IsSafeDeviceParams.tParams));

        expect(
            result,
            equals(Left(ServerFailure.fromServerException(
                ServerException.tServerException))));
      },
    );

    test(
      'should return app failure on app exception',
      () async {
        // arrange
        when(remoteDataSource.isSafeDevice(any))
            .thenThrow(AppException.tAppException);
        // act
        final result =
            await repositoryImpl.isSafeDevice(IsSafeDeviceParams.tParams);
        // assert
        verify(remoteDataSource.isSafeDevice(IsSafeDeviceParams.tParams));

        expect(
            result,
            equals(
                Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
  });
}
