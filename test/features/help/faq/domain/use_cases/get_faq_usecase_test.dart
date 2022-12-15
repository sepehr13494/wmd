import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_response.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/use_cases/get_assets_overview_usecase.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';
import 'package:wmd/features/help/faq/domain/use_cases/get_faq_usecase.dart';

import '../../data/repositories/faq_repository_impl_test.mocks.dart';

void main() {
  late GetFaqUseCase getFaqUseCase;
  late MockFaqRepository mockFaqRepository;

  setUp(() {
    mockFaqRepository = MockFaqRepository();
    getFaqUseCase = GetFaqUseCase(mockFaqRepository);
  });

  final tNoParams = NoParams();

  test('should get faqs from the repository', () async {
    //arrange
    when(mockFaqRepository.getFAQs(any))
        .thenAnswer((_) async => Right(Faq.tFaqListParams));
    // act
    final result = await getFaqUseCase(tNoParams);

    // assert
    expect(result, equals(Right(Faq.tFaqListParams)));
  });

  test(
    'should get Server Failure from the repository when server request fails',
    () async {
      //arrange
      when(mockFaqRepository.getFAQs(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getFaqUseCase(tNoParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockFaqRepository.getFAQs(tNoParams));
    },
  );
}
