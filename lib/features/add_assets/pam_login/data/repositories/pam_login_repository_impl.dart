import 'dart:developer';
import 'dart:io';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/jwt_parser.dart';

import '../models/get_mandates_params.dart';

import '../models/login_pam_account_params.dart';

import '../../domain/repositories/pam_login_repository.dart';
import '../data_sources/pam_login_remote_datasource.dart';

class PamLoginRepositoryImpl implements PamLoginRepository {
  final PamLoginRemoteDataSource remoteDataSource;

  PamLoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AppSuccess>> getMandates(
      GetMandatesParams params) async {
    try {
      final result = await remoteDataSource.getMandates(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> loginPamAccount(
      LoginPamAccountParams params) async {
    try {
      final auth0 = Auth0(
          AppConstants.pamAuth0IssuerBaseUrl, AppConstants.pamAuth0ClientId);
      late final Credentials credentials;
      if (Platform.isAndroid) {
        credentials =
            await auth0.webAuthentication(scheme: AppConstants.appId).login();
      } else {
        credentials = await auth0.webAuthentication().login();
      }
      final claims = parseJwt(credentials.idToken);
      log('Mert log Pam $claims');
      final mandates = claims['mandate'];
      log('Mert log Pam $mandates');
      if (mandates == null) {
        throw Exception('No mandates found');
      }
      final result = await remoteDataSource.loginPamAccount(mandates);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    } on Exception catch (error) {
      final messages = error.toString().split(':');
      if (messages.length > 1) {
        return Left(AppFailure(message: messages[1]));
      } else {
        return Left(AppFailure(message: error.toString()));
      }
    }
  }
}
