import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_schedule_call_usecase.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';

import 'general_inquiry_cubit_test.mocks.dart';

@GenerateMocks([PostGeneralInquiryUseCase, PostScheduleCallUseCase])
void main() {
  late MockPostGeneralInquiryUseCase mockPostGeneralInquiryUseCase;
  late MockPostScheduleCallUseCase mockPostScheduleCallUseCase;
  late GeneralInquiryCubit generalInquiryCubit;

  setUp(() {
    mockPostGeneralInquiryUseCase = MockPostGeneralInquiryUseCase();
    mockPostScheduleCallUseCase = MockPostScheduleCallUseCase();
    generalInquiryCubit = GeneralInquiryCubit(
        mockPostGeneralInquiryUseCase, mockPostScheduleCallUseCase);
  });

  group("getFAQs", () {
    blocTest(
      'when postGeneralInquiry is emits the GeneralInquirySaved when success',
      build: () => generalInquiryCubit,
      setUp: () => when(mockPostGeneralInquiryUseCase(any)).thenAnswer(
          (realInvocation) async =>
              const Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.postGeneralInquiry(
          map: GeneralInquiryParams.tGeneralInquiryMap),
      expect: () => [
        isA<LoadingState>(),
        SuccessState(appSuccess: const AppSuccess(message: "successfully done"))
      ],
      verify: (_) {
        verify(mockPostGeneralInquiryUseCase(
            GeneralInquiryParams.tGeneralInquiryMap));
      },
    );

    blocTest(
      'when postGeneralInquiry is emits the ErrorState when error',
      build: () => generalInquiryCubit,
      setUp: () => when(mockPostGeneralInquiryUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.postGeneralInquiry(
          map: GeneralInquiryParams.tGeneralInquiryMap),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockPostGeneralInquiryUseCase(
            GeneralInquiryParams.tGeneralInquiryMap));
      },
    );
  });
}
