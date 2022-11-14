import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/forget_password/data/data_sources/forget_password_server_datasource.dart';
import 'package:wmd/features/authentication/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/forget_password_usecase.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/reset_password_usecase.dart';

class ForgetPasswordRepositoryImpl extends ForgetPasswordRepository {
  final ForgetPasswordServerDataSource forgetPasswordServerDataSource;

  ForgetPasswordRepositoryImpl(this.forgetPasswordServerDataSource);

  @override
  Future<Either<Failure, AppSuccess>> forgetPassword(
      ForgetPasswordParams forgetPasswordParams) async {
    try {
      final result = await forgetPasswordServerDataSource
          .forgetPassword(forgetPasswordParams);
      return const Right(AppSuccess(message: 'Email sent successfully'));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> resetPassword(
      ResetPasswordParams resetPasswordParams) async {
    try {
      final result = await forgetPasswordServerDataSource
          .resetPassword(resetPasswordParams);
      return const Right(AppSuccess(message: 'Password reset successfully'));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }
}
