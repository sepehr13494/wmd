import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/splash/data/repositories/splash_repository_impl.dart';

import '../../../../core/util/local_storage_test.mocks.dart';


void main(){
  late SplashRepositoryImpl splashRepositoryImpl;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    splashRepositoryImpl = SplashRepositoryImpl(mockLocalStorage);
  });
  
  test('checkLogin method when get login from local storage returns data',() async {
      //arrange
      when(mockLocalStorage.getLogin()).thenAnswer((realInvocation) async => true);
      //act
      final result = await splashRepositoryImpl.checkLogin(NoParams());
      //assert
      verify(mockLocalStorage.getLogin());
      expect(result, const Right(true));
  });

  test('checkLogin method when get login from local storage returns any exception',() async {
    //arrange
    final tException = Exception("test");
    when(mockLocalStorage.getLogin()).thenThrow((realInvocation) async => tException);
    //act
    final result = await splashRepositoryImpl.checkLogin(NoParams());
    //assert
    verify(mockLocalStorage.getLogin());
    expect(result, isA<Left>().having((l) => l.value, 'value', isA<CacheFailure>()));

  });
}