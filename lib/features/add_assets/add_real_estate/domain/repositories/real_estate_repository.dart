import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

abstract class RealEstateRepository {
  Future<Either<Failure, AddAsset>> postRealEstate(
      AddRealEstateParams addRealEstateParams);
}
