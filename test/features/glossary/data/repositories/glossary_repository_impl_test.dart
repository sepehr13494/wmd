import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/glossary/data/data_sources/glossary_remote_datasource.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_params.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_response.dart';
import 'package:wmd/features/glossary/data/repositories/glossary_repository_impl.dart';
import 'package:wmd/features/glossary/domain/repositories/glossary_repository.dart';

import 'glossary_repository_impl_test.mocks.dart';


@GenerateMocks([GlossaryRemoteDataSource,GlossaryRepository])
void main() {
  late MockGlossaryRemoteDataSource remoteDataSource;
  late GlossaryRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockGlossaryRemoteDataSource();
    repositoryImpl = GlossaryRepositoryImpl(
        remoteDataSource);
  });

  group('GetGlossaries', () {
    test(
      'should return GetGlossariesResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getGlossaries(any))
            .thenAnswer((_) async => GetGlossariesResponse.tResponse);
        // act
        final result = await repositoryImpl.getGlossaries(GetGlossariesParams.tParams);
        // assert
        expect(result, equals(Right(GetGlossariesResponse.tResponse)));
        verify(remoteDataSource.getGlossaries(GetGlossariesParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getGlossaries(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getGlossaries(GetGlossariesParams.tParams);
        // assert
        verify(remoteDataSource.getGlossaries(GetGlossariesParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getGlossaries(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getGlossaries(GetGlossariesParams.tParams);
        // assert
        verify(remoteDataSource.getGlossaries(GetGlossariesParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
