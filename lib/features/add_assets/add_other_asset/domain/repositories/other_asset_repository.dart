import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

abstract class OtherAssetRepository {
  Future<Either<Failure, AddAsset>> postOtherAsset(
      AddOtherAssetParams addOtherAssetParams);
}
