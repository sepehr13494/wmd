import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';

import '../../../../core/error_and_success/exeptions.dart';
import '../../../../core/error_and_success/succeses.dart';
import '../../../../core/util/local_storage.dart';
import '../../domain/use_cases/resend_email_usecase.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../../../../core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/post_login_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Local storage will be used for saving access token from the request
  // to the sharedPreferences or local storage, so we can keep using it from local storage
  final LocalStorage localStorage;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(
    this.localStorage,
    this.authRemoteDataSource,
  );

  @override
  Future<Either<Failure, AppSuccess>> login(LoginParams loginParams) async {
    try {
      final result = await authRemoteDataSource.login(loginParams);
      localStorage.setTokenAndLogin(result.accessToken);
      localStorage.setRefreshToken(result.refreshToken);
      return const Right(AppSuccess(message: 'Login successful'));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } on CacheException catch (cacheError) {
      return Left(CacheFailure(message: cacheError.message));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> register(
      RegisterParams registerParams) async {
    try {
      final result = await authRemoteDataSource.register(registerParams);
      return const Right(AppSuccess(message: 'Register successful'));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> resendEmail(ResendEmailParams resendEmailParams) async {
    try {
      final result = await authRemoteDataSource.resendEmail(resendEmailParams);
      return const Right(AppSuccess(message: 'Email sent successful'));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }
}
