import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/force_update/data/data_sources/force_update_remote_datasource.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_params.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_response.dart';
import 'package:wmd/features/force_update/data/repositories/force_update_repository_impl.dart';
import 'package:wmd/features/force_update/domain/repositories/force_update_repository.dart';

import 'force_update_repository_impl_test.mocks.dart';


@GenerateMocks([ForceUpdateRemoteDataSource,ForceUpdateRepository])
void main() {
  late MockForceUpdateRemoteDataSource remoteDataSource;
  late ForceUpdateRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockForceUpdateRemoteDataSource();
    repositoryImpl = ForceUpdateRepositoryImpl(
        remoteDataSource);
  });

  group('GetForceUpdate', () {
    test(
      'should return GetForceUpdateResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getForceUpdate(any))
            .thenAnswer((_) async => GetForceUpdateResponse.tResponse);
        // act
        final result = await repositoryImpl.getForceUpdate(GetForceUpdateParams.tParams);
        // assert
        expect(result, equals(Right(GetForceUpdateResponse.tResponse)));
        verify(remoteDataSource.getForceUpdate(GetForceUpdateParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getForceUpdate(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getForceUpdate(GetForceUpdateParams.tParams);
        // assert
        verify(remoteDataSource.getForceUpdate(GetForceUpdateParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getForceUpdate(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getForceUpdate(GetForceUpdateParams.tParams);
        // assert
        verify(remoteDataSource.getForceUpdate(GetForceUpdateParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
