import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_other_asset/data/data_sources/other_asset_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/repositories/other_asset_repository.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class OtherAssetRepositoryImpl implements OtherAssetRepository {
  final OtherAssetRemoteDataSource otherAssetRemoteDataSource;

  OtherAssetRepositoryImpl(this.otherAssetRemoteDataSource);
  @override
  Future<Either<Failure, AddAsset>> postOtherAsset(
      AddOtherAssetParams addOtherAssetParams) async {
    try {
      final result =
          await otherAssetRemoteDataSource.postOtherAsset(addOtherAssetParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
