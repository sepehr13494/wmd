import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/splash/domain/repositories/splash_repository.dart';
import 'package:wmd/features/splash/domain/use_cases/check_login_usecase.dart';

import 'check_login_usecase_test.mocks.dart';

@GenerateMocks([SplashRepository])
void main(){
  late MockSplashRepository mockSplashRepository;
  late CheckLoginUseCase checkLoginUseCase;

  setUp(() {
    mockSplashRepository = MockSplashRepository();
    checkLoginUseCase = CheckLoginUseCase(mockSplashRepository);
  });

  group('check login usecase test', () {

    test(
      'should get isLogin user splash repository',
          () async {
        //arrange
        when(mockSplashRepository.checkLogin(NoParams())).thenAnswer((realInvocation) async => const Right(true));
        //act
        final result = await checkLoginUseCase(NoParams());
        //assert
        verify(mockSplashRepository.checkLogin(NoParams()));
        expect(result, const Right(true));
        verifyNoMoreInteractions(mockSplashRepository);
      },
    );

    test(
      'should return failure when isLogin returns failure',
          () async {
        //arrange
        when(mockSplashRepository.checkLogin(NoParams())).thenAnswer((realInvocation) async => const Left(CacheFailure(message: "test")));
        //act
        final result = await checkLoginUseCase(NoParams());
        //assert
        verify(mockSplashRepository.checkLogin(NoParams()));
        expect(result, isA<Left>().having((l) => l.value, 'value', isA<Failure>()));
        verifyNoMoreInteractions(mockSplashRepository);
      },
    );

  });

}