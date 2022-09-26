import '../../../../core/data/network/network_info.dart';
import '../../../../core/error_and_success/exeptions.dart';
import '../../../../core/error_and_success/succeses.dart';
import '../../../../core/util/local_storage.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../../core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../usecases/post_login_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Local storage will be used for saving access token from the request
  // to the sharedPreferences or local storage, so we can keep using it from local storage
  final LocalStorage localStorage;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.localStorage,
    required this.authRemoteDataSource,
  });

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
  Future<Either<Failure, AppSuccess>> register(LoginParams loginParams) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
