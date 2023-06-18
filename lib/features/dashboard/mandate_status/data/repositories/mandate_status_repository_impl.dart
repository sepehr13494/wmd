import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/get_mandate_status_params.dart';
import '../../domain/entities/get_mandate_status_entity.dart';
import '../models/delete_mandate_params.dart';

import '../../domain/repositories/mandate_status_repository.dart';
import '../data_sources/mandate_status_remote_datasource.dart';

class MandateStatusRepositoryImpl implements MandateStatusRepository {
  final MandateStatusRemoteDataSource remoteDataSource;

  MandateStatusRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<GetMandateStatusEntity>>> getMandateStatus(
      GetMandateStatusParams params) async {
    try {
      final result = await remoteDataSource.getMandateStatus(params);
      result.removeWhere((e) => e.dataSource == 'WMD');
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> deleteMandate(
      DeleteMandateParams params) async {
    try {
      final result = await remoteDataSource.deleteMandate(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
