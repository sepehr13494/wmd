import 'dart:convert';
import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/jwt_parser.dart';

import '../models/get_mandates_params.dart';

import '../models/login_tfo_account_params.dart';

import '../../domain/repositories/tfo_login_repository.dart';
import '../data_sources/tfo_login_remote_datasource.dart';

class TfoLoginRepositoryImpl implements TfoLoginRepository {
  final TfoLoginRemoteDataSource remoteDataSource;

  TfoLoginRepositoryImpl(this.remoteDataSource);

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
  Future<Either<Failure, AppSuccess>> loginTfoAccount(
      LoginTfoAccountParams params) async {
    try {
      final auth0 = Auth0(
          AppConstants.tfoAuth0IssuerBaseUrl, AppConstants.tfoAuth0ClientId);
      final Credentials credentials = await auth0.webAuthentication().login();
      final claims = parseJwt(credentials.idToken);
      log('Mert log TFO $claims');
      final mandates = claims['mandate'];
      log('Mert log TFO $mandates');
      if (mandates == null) {
        throw Exception('There is no mandate in this accout');
      }
      final result = await remoteDataSource.loginTfoAccount(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    } on Exception catch (error) {
      final messages = error.toString().split(':');
      log('Mert log TFO $messages');
      if (messages.length > 1) {
        return Left(AppFailure(message: messages[1]));
      } else {
        return Left(AppFailure(message: error.toString()));
      }
    }
  }
}
