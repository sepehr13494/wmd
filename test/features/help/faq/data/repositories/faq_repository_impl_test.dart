import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/help/faq/data/data_sources/faq_remote_data_source.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';
import 'package:wmd/features/help/faq/data/repositories/faq_respository_impl.dart';
import 'package:wmd/features/help/faq/domain/repositories/faq_repository.dart';

import 'faq_repository_impl_test.mocks.dart';

@GenerateMocks([FaqRemoteDataSource, FaqRepository])
void main() {
  late MockFaqRemoteDataSource remoteDataSource;
  late FaqRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockFaqRemoteDataSource();
    repositoryImpl = FaqRepositoryImpl(remoteDataSource);
  });

  final tNoParams = NoParams();
  const tServerException = ServerException(message: 'test server message');

  group('test for getFAQs in FaqRepository', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getFAQs(any))
            .thenAnswer((_) async => Faq.tFaqListParams);
        // act
        final result = await repositoryImpl.getFAQs(tNoParams);
        // assert
        expect(result, equals(Right(Faq.tFaqListParams)));
        verify(remoteDataSource.getFAQs(tNoParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getFAQs(any)).thenThrow(tServerException);
        // act
        final result = await repositoryImpl.getFAQs(tNoParams);
        // assert
        verify(remoteDataSource.getFAQs(tNoParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
