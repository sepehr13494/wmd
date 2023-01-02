import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/help/support/data/data_sources/general_inquiry_remote_data_source.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/data/repositories/general_inquiry_respository_impl.dart';
import 'package:wmd/features/help/support/domain/repositories/general_inquiry_repository.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

import 'general_inquiry_repository_impl_test.mocks.dart';

@GenerateMocks([GeneralInquiryRemoteDataSource, GeneralInquiryRepository])
void main() {
  late MockGeneralInquiryRemoteDataSource remoteDataSource;
  late GeneralInquiryRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockGeneralInquiryRemoteDataSource();
    repositoryImpl = GeneralInquiryRepositoryImpl(remoteDataSource);
  });

  final tStatus = SupportStatus();
  const tServerException = ServerException(message: 'test server message');

  group('test for postGeneralInquiry in FaqRepository', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.postGeneralInquiry(any))
            .thenAnswer((_) async => tStatus);
        // act
        final result = await repositoryImpl
            .postGeneralInquiry(GeneralInquiryParams.tGeneralInquiryParams);
        // assert
        expect(result,
            equals(const Right(AppSuccess(message: "successfully done"))));
        verify(remoteDataSource
            .postGeneralInquiry(GeneralInquiryParams.tGeneralInquiryParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.postGeneralInquiry(any))
            .thenThrow(tServerException);
        // act
        final result = await repositoryImpl
            .postGeneralInquiry(GeneralInquiryParams.tGeneralInquiryParams);
        // assert
        verify(remoteDataSource
            .postGeneralInquiry(GeneralInquiryParams.tGeneralInquiryParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
