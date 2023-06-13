import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_params.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_response.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/use_cases/get_mandate_status_usecase.dart';


import '../../data/repositories/mandate_status_repository_impl_test.mocks.dart';




void main() {
  late GetMandateStatusUseCase getMandateStatusUseCase;
  late MockMandateStatusRepository mockMandateStatusRepository;

  setUp(() {
    mockMandateStatusRepository = MockMandateStatusRepository();
    getMandateStatusUseCase = GetMandateStatusUseCase(mockMandateStatusRepository);
  });

  test('should get GetMandateStatusEntity from the repository', () async {
    //arrange
    when(mockMandateStatusRepository.getMandateStatus(any))
        .thenAnswer((_) async => Right(GetMandateStatusResponse.tResponse));
    // act
    final result = await getMandateStatusUseCase(GetMandateStatusParams.tParams);

    // assert
    expect(result, equals(Right(GetMandateStatusResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockMandateStatusRepository.getMandateStatus(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getMandateStatusUseCase(GetMandateStatusParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockMandateStatusRepository.getMandateStatus(GetMandateStatusParams.tParams));
    },
  );
}

    