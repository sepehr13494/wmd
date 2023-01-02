import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

import '../../data/repositories/general_inquiry_repository_impl_test.mocks.dart';

void main() {
  late PostGeneralInquiryUseCase useCase;
  late MockGeneralInquiryRepository mockRepository;

  setUp(() {
    mockRepository = MockGeneralInquiryRepository();
    useCase = PostGeneralInquiryUseCase(mockRepository);
  });

  test('should get general inquiry from the repository', () async {
    //arrange
    when(mockRepository.postGeneralInquiry(any)).thenAnswer(
        (_) async => const Right(AppSuccess(message: "successfully done")));
    // act
    final result = await useCase(GeneralInquiryParams.tGeneralInquiryMap);

    // assert
    expect(
        result, equals(const Right(AppSuccess(message: "successfully done"))));
  });

  test(
    'should get Server Failure from the repository when server request fails',
    () async {
      //arrange
      when(mockRepository.postGeneralInquiry(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await useCase(GeneralInquiryParams.tGeneralInquiryMap);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockRepository
          .postGeneralInquiry(GeneralInquiryParams.tGeneralInquiryParams));
    },
  );
}
