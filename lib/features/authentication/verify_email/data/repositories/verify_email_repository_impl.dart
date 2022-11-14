import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/verify_email/data/data_sources/verify_email_server_datasource.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_params.dart';
import 'package:wmd/features/authentication/verify_email/domain/repositories/verify_email_repository.dart';

class VerifyEmailRepositoryImpl extends VerifyEmailRepository{

  final VerifyEmailServerDataSource verifyEmailServerDataSource;

  VerifyEmailRepositoryImpl(this.verifyEmailServerDataSource);

  @override
  Future<Either<Failure, AppSuccess>> verifyEmail(VerifyEmailParams verifyEmailParams) async {
    try {
      final result = await verifyEmailServerDataSource.verifyEmail(verifyEmailParams);
      return const Right(AppSuccess(message: 'Email verified successful'));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }

}