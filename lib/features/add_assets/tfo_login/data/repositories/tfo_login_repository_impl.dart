import 'dart:developer';
import 'dart:io';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:nonce/nonce.dart';
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
      
      final resp = await remoteDataSource.loginTfoAccount(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    } on Exception catch (error) {
      final messages = error.toString().split(':');
      log('Mert log exception ${error.toString()}');
      if (messages.length > 1) {
        return Left(AppFailure(message: messages[1]));
      } else {
        return Left(AppFailure(message: error.toString()));
      }
    }
  }
}

