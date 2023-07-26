import 'dart:developer';

import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/profile/personal_information/domain/entities/user_mandata_entity.dart';

import '../models/get_name_params.dart';
import '../../domain/entities/get_name_entity.dart';
import '../models/set_name_params.dart';
import '../models/set_number_params.dart';

import '../../domain/repositories/personal_information_repository.dart';
import '../data_sources/personal_information_remote_datasource.dart';

class PersonalInformationRepositoryImpl
    implements PersonalInformationRepository {
  final PersonalInformationRemoteDataSource remoteDataSource;

  PersonalInformationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, GetNameEntity>> getName(GetNameParams params) async {
    try {
      final result = await remoteDataSource.getName(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      log(error.toString());
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> setName(SetNameParams params) async {
    try {
      final result = await remoteDataSource.setName(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      log(error.toString());
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> setNumber(SetNumberParams params) async {
    try {
      await remoteDataSource.setNumber(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }

  @override
  Future<Either<Failure, List<UserMandateEntity>>> getUserMandate(
      NoParams params) async {
    try {
      final result = await remoteDataSource.getUserMandate(params);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
