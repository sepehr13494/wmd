import 'package:flutter/material.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';

import '../../domain/use_cases/resend_email_usecase.dart';
import '../data_sources/login_sign_up_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/login_sign_up_repository.dart';
import '../../domain/use_cases/post_login_usecase.dart';

class LoginSignUpRepositoryImpl implements LoginSignUpRepository {
  // Local storage will be used for saving access token from the request
  // to the sharedPreferences or local storage, so we can keep using it from local storage
  final LocalStorage localStorage;
  final LoginSignUpRemoteDataSource loginSignUpRemoteDataSource;

  LoginSignUpRepositoryImpl(
    this.localStorage,
    this.loginSignUpRemoteDataSource,
  );

  @override
  Future<Either<Failure, AppSuccess>> login(LoginParams loginParams) async {
    try {
      final result = await loginSignUpRemoteDataSource.login(loginParams);
      localStorage.setTokenAndLogin(result.accessToken);
      localStorage.setRefreshToken(result.refreshToken);
      return const Right(AppSuccess(message: 'Login successful'));
    } on ServerException catch (error) {
      debugPrint(error.message);
      if (error.message == "Wrong email or password.") {
        return const Left(ServerFailure(
            message: "Invalid email or password, Please try again."));
      } else {
        return Left(ServerFailure.fromServerException(error));
      }
    } on CacheException catch (cacheError) {
      return Left(CacheFailure(message: cacheError.message));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> register(
      RegisterParams registerParams) async {
    try {
      final result = await loginSignUpRemoteDataSource.register(registerParams);
      localStorage.setTokenAndLogin(result.accessToken);
      localStorage.setRefreshToken(result.refreshToken);
      return const Right(AppSuccess(message: 'Register successful'));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on CacheException catch (cacheError) {
      return Left(CacheFailure(message: cacheError.message));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> resendEmail(
      ResendEmailParams resendEmailParams) async {
    try {
      final Map<String, dynamic> result =
          await loginSignUpRemoteDataSource.resendEmail(resendEmailParams);
      if (!result["success"]) {
        return Left(ServerFailure(message: result["message"]));
      }

      return const Right(AppSuccess(message: 'Email sent successful'));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
