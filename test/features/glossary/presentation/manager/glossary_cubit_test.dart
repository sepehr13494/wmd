    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_params.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_response.dart';
import 'package:wmd/features/glossary/domain/use_cases/get_glossaries_usecase.dart';
import 'package:wmd/features/glossary/presentation/manager/glossary_cubit.dart';

import 'glossary_cubit_test.mocks.dart';



@GenerateMocks([
  GetGlossariesUseCase,

])
void main() {
  late MockGetGlossariesUseCase mockGetGlossariesUseCase;

  late GlossaryCubit glossaryCubit;


  setUp(() {
    mockGetGlossariesUseCase = MockGetGlossariesUseCase();

    glossaryCubit = GlossaryCubit(
    mockGetGlossariesUseCase,

    );
  });
  

  group("getGlossaries", () {
    blocTest(
      'when GetGlossariesUseCase emits the GetGlossariesLoaded when success',
      build: () => glossaryCubit,
      setUp: () => when(mockGetGlossariesUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetGlossariesResponse.tResponse)),
      act: (bloc) async => await bloc.getGlossaries(),
      expect: () =>
      [isA<LoadingState>(), GetGlossariesLoaded(getGlossariesEntities : GetGlossariesResponse.tResponse)],
      verify: (_) {
        verify(mockGetGlossariesUseCase(GetGlossariesParams.tParams));
      },
    );

    blocTest(
      'when GetGlossariesUseCase emits the ErrorState when error',
      build: () => glossaryCubit,
      setUp: () => when(mockGetGlossariesUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getGlossaries(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetGlossariesUseCase(GetGlossariesParams.tParams));
      },
    );
  });

}

    