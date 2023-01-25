import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/post_verify_phone_params.dart';

import '../models/post_resend_verify_phone_params.dart';

import '../../domain/repositories/verify_phone_repository.dart';
import '../data_sources/verify_phone_remote_datasource.dart';

class VerifyPhoneRepositoryImpl implements VerifyPhoneRepository {
  final VerifyPhoneRemoteDataSource remoteDataSource;

  VerifyPhoneRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AppSuccess>> postVerifyPhone(
      PostVerifyPhoneParams params) async {
    try {
      final result = await remoteDataSource.postVerifyPhone(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> postResendVerifyPhone(
      PostResendVerifyPhoneParams params) async {
    try {
      final result = await remoteDataSource.postResendVerifyPhone(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
