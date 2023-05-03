import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_params.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_response.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/domain/use_cases/get_client_index_usecase.dart';


import '../../data/repositories/client_index_repository_impl_test.mocks.dart';




void main() {
  late GetClientIndexUseCase getClientIndexUseCase;
  late MockClientIndexRepository mockClientIndexRepository;

  setUp(() {
    mockClientIndexRepository = MockClientIndexRepository();
    getClientIndexUseCase = GetClientIndexUseCase(mockClientIndexRepository);
  });

  test('should get GetClientIndexEntity from the repository', () async {
    //arrange
    when(mockClientIndexRepository.getClientIndex(any))
        .thenAnswer((_) async => Right(GetClientIndexResponse.tResponse));
    // act
    final result = await getClientIndexUseCase(GetClientIndexParams.tParams);

    // assert
    expect(result, equals(Right(GetClientIndexResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockClientIndexRepository.getClientIndex(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getClientIndexUseCase(GetClientIndexParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockClientIndexRepository.getClientIndex(GetClientIndexParams.tParams));
    },
  );
}

    