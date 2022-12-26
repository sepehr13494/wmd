import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';

import 'general_inquiry_cubit_test.mocks.dart';

@GenerateMocks([PostGeneralInquiryUseCase])
void main() {
  late MockPostGeneralInquiryUseCase mockPostGeneralInquiryUseCase;
  late GeneralInquiryCubit generalInquiryCubit;

  setUp(() {
    mockPostGeneralInquiryUseCase = MockPostGeneralInquiryUseCase();
    generalInquiryCubit = GeneralInquiryCubit(mockPostGeneralInquiryUseCase);
  });

  final tUserStatus = SupportStatus(
      email: "test@yopmail.com",
      loginAt: CustomizableDateTime.current.toString());

  group("getFAQs", () {
    blocTest(
      'when postGeneralInquiry is emits the GeneralInquirySaved when success',
      build: () => generalInquiryCubit,
      setUp: () => when(mockPostGeneralInquiryUseCase(any))
          .thenAnswer((realInvocation) async => Right(tUserStatus)),
      act: (bloc) async => await bloc.postGeneralInquiry(
          map: GeneralInquiryParams.tGeneralInquiryMap),
      expect: () =>
          [isA<LoadingState>(), GeneralInquirySaved(status: tUserStatus)],
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
