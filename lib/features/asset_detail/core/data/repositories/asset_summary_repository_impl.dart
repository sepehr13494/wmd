import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_summary_params.dart';
import '../../domain/entities/asset_summary_entity.dart';
import '../../domain/repositories/asset_summary_repository.dart';
import '../data_sources/asset_summart_datasource.dart';

class AssetSummaryRepositoryImpl implements AssetSummaryRepository {
  final AssetSummaryRemoteDataSource remoteDataSource;

  AssetSummaryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AssetSummaryEntitiy>> getSummary(
      GetSummaryParams params) async {
    try {
      final result = await remoteDataSource.getSummary(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
