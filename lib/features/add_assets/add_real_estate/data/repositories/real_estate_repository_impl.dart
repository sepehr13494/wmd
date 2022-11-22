import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_real_estate/data/data_sources/real_estate_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/repositories/real_estate_repository.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class RealEstateRepositoryImpl implements RealEstateRepository {
  final RealEstateRemoteDataSource realEstateRemoteDataSource;

  RealEstateRepositoryImpl(this.realEstateRemoteDataSource);
  @override
  Future<Either<Failure, AddAsset>> postRealEstate(
      AddRealEstateParams addRealEstateParams) async {
    try {
      final result =
          await realEstateRemoteDataSource.postRealEstate(addRealEstateParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
