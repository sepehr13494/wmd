import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/delete_mandate_params.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/use_cases/delete_mandate_usecase.dart';

import '../../data/repositories/mandate_status_repository_impl_test.mocks.dart';




void main() {
  late DeleteMandateUseCase deleteMandateUseCase;
  late MockMandateStatusRepository mockMandateStatusRepository;

  setUp(() {
    mockMandateStatusRepository = MockMandateStatusRepository();
    deleteMandateUseCase = DeleteMandateUseCase(mockMandateStatusRepository);
  });

  test('should get DeleteMandateEntity from the repository', () async {
    //arrange
    when(mockMandateStatusRepository.deleteMandate(any))
        .thenAnswer((_) async => Right(AppSuccess()));
    // act
    final result = await deleteMandateUseCase(DeleteMandateParams.tParams);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockMandateStatusRepository.deleteMandate(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await deleteMandateUseCase(DeleteMandateParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockMandateStatusRepository.deleteMandate(DeleteMandateParams.tParams));
    },
  );
}

    