import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_listed_security/data/data_sources/listed_security_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_listed_security/data/repositories/listed_security_repository_impl.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'listed_security_repository_impl_test.mocks.dart';

@GenerateMocks([ListedSecurityRemoteDataSource])
void main() {
  late MockListedSecurityRemoteDataSource mockListedSecurityRemoteDataSource;
  late ListedSecurityRepositoryImpl listedSecurityRepositoryImpl;

  setUp(() {
    mockListedSecurityRemoteDataSource = MockListedSecurityRemoteDataSource();
    listedSecurityRepositoryImpl =
        ListedSecurityRepositoryImpl(mockListedSecurityRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for postListedSecurity in Listed Security Repository', () {
    test(
      'should return save response data when the call to Listed Security remote data source is successful',
      () async {
        // arrange
        when(mockListedSecurityRemoteDataSource.postListedSecurity(any))
            .thenAnswer((_) async => AddAssetModel.tAddAssetModel);
        // act
        final result = await listedSecurityRepositoryImpl.postListedSecurity(
            AddListedSecurityParams.tAddListedSecurityParams);
        // assert
        verify(mockListedSecurityRemoteDataSource.postListedSecurity(
            AddListedSecurityParams.tAddListedSecurityParams));
        expect(result, equals(const Right(AddAssetModel.tAddAssetModel)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockListedSecurityRemoteDataSource.postListedSecurity(any))
            .thenThrow(tServerException);
        // act
        final result = await listedSecurityRepositoryImpl.postListedSecurity(
            AddListedSecurityParams.tAddListedSecurityParams);
        // assert
        verify(mockListedSecurityRemoteDataSource.postListedSecurity(
            AddListedSecurityParams.tAddListedSecurityParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
