import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_params.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_response.dart';
import 'package:wmd/features/glossary/domain/use_cases/get_glossaries_usecase.dart';


import '../../data/repositories/glossary_repository_impl_test.mocks.dart';




void main() {
  late GetGlossariesUseCase getGlossariesUseCase;
  late MockGlossaryRepository mockGlossaryRepository;

  setUp(() {
    mockGlossaryRepository = MockGlossaryRepository();
    getGlossariesUseCase = GetGlossariesUseCase(mockGlossaryRepository);
  });

  test('should get GetGlossariesEntity from the repository', () async {
    //arrange
    when(mockGlossaryRepository.getGlossaries(any))
        .thenAnswer((_) async => Right(GetGlossariesResponse.tResponse));
    // act
    final result = await getGlossariesUseCase(GetGlossariesParams.tParams);

    // assert
    expect(result, equals(Right(GetGlossariesResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockGlossaryRepository.getGlossaries(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getGlossariesUseCase(GetGlossariesParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockGlossaryRepository.getGlossaries(GetGlossariesParams.tParams));
    },
  );
}

    