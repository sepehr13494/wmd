import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/data_sources/client_index_remote_datasource.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_params.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_response.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/repositories/client_index_repository_impl.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/domain/repositories/client_index_repository.dart';

import 'client_index_repository_impl_test.mocks.dart';


@GenerateMocks([ClientIndexRemoteDataSource,ClientIndexRepository])
void main() {
  late MockClientIndexRemoteDataSource remoteDataSource;
  late ClientIndexRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockClientIndexRemoteDataSource();
    repositoryImpl = ClientIndexRepositoryImpl(
        remoteDataSource);
  });

  group('GetClientIndex', () {
    test(
      'should return GetClientIndexResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getClientIndex(any))
            .thenAnswer((_) async => GetClientIndexResponse.tResponse);
        // act
        final result = await repositoryImpl.getClientIndex(GetClientIndexParams.tParams);
        // assert
        expect(result, equals(Right(GetClientIndexResponse.tResponse)));
        verify(remoteDataSource.getClientIndex(GetClientIndexParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getClientIndex(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getClientIndex(GetClientIndexParams.tParams);
        // assert
        verify(remoteDataSource.getClientIndex(GetClientIndexParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getClientIndex(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getClientIndex(GetClientIndexParams.tParams);
        // assert
        verify(remoteDataSource.getClientIndex(GetClientIndexParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
