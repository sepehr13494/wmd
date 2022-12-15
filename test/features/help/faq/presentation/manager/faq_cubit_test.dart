import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';
import 'package:wmd/features/help/faq/domain/use_cases/get_faq_usecase.dart';
import 'package:wmd/features/help/faq/presentation/manager/faq_cubit.dart';

import 'faq_cubit_test.mocks.dart';

@GenerateMocks([GetFaqUseCase])
void main() {
  late MockGetFaqUseCase mockGetFaqUseCase;
  late FaqCubit faqCubit;

  setUp(() {
    mockGetFaqUseCase = MockGetFaqUseCase();
    faqCubit = FaqCubit(mockGetFaqUseCase);
  });

  final tNoParams = NoParams();

  group("getFAQs", () {
    blocTest(
      'when getFaqUseCase is emits the FaqLoaded when success',
      build: () => faqCubit,
      setUp: () => when(mockGetFaqUseCase(any))
          .thenAnswer((realInvocation) async => Right(Faq.tFaqListParams)),
      act: (bloc) async => await bloc.getFAQs(),
      expect: () => [isA<LoadingState>(), FaqLoaded(faqs: Faq.tFaqListParams)],
      verify: (_) {
        verify(mockGetFaqUseCase(tNoParams));
      },
    );

    blocTest(
      'when getFaqUseCase is emits the ErrorState when error',
      build: () => faqCubit,
      setUp: () => when(mockGetFaqUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getFAQs(),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockGetFaqUseCase(tNoParams));
      },
    );
  });
}
