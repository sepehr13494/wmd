import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';

import '../models/get_detail_params.dart';
import '../../domain/entities/get_detail_entity.dart';

import '../../domain/repositories/asset_detail_repository.dart';
import '../data_sources/asset_detail_remote_datasource.dart';

class AssetDetailRepositoryImpl implements AssetDetailRepository {
  final AssetDetailRemoteDataSource remoteDataSource;

  AssetDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, GetDetailEntity>> getDetail(
      GetDetailParams params) async {
    try {
      final result = await remoteDataSource.getDetail(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
