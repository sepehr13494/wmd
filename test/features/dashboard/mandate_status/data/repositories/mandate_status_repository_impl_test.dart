import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/mandate_status/data/data_sources/mandate_status_remote_datasource.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_params.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_response.dart';
import 'package:wmd/features/dashboard/mandate_status/data/repositories/mandate_status_repository_impl.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/repositories/mandate_status_repository.dart';

import 'mandate_status_repository_impl_test.mocks.dart';


@GenerateMocks([MandateStatusRemoteDataSource,MandateStatusRepository])
void main() {
  late MockMandateStatusRemoteDataSource remoteDataSource;
  late MandateStatusRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockMandateStatusRemoteDataSource();
    repositoryImpl = MandateStatusRepositoryImpl(
        remoteDataSource);
  });

  group('GetMandateStatus', () {
    test(
      'should return GetMandateStatusResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getMandateStatus(any))
            .thenAnswer((_) async => GetMandateStatusResponse.tResponse);
        // act
        final result = await repositoryImpl.getMandateStatus(GetMandateStatusParams.tParams);
        // assert
        expect(result, equals(Right(GetMandateStatusResponse.tResponse)));
        verify(remoteDataSource.getMandateStatus(GetMandateStatusParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getMandateStatus(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getMandateStatus(GetMandateStatusParams.tParams);
        // assert
        verify(remoteDataSource.getMandateStatus(GetMandateStatusParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getMandateStatus(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getMandateStatus(GetMandateStatusParams.tParams);
        // assert
        verify(remoteDataSource.getMandateStatus(GetMandateStatusParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
