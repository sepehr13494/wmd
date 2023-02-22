import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_assets_geography_params.dart';
import '../entities/get_assets_geography_entity.dart';


abstract class AssetsGeographyChartRepository {
  Future<Either<Failure, List<GetAssetsGeographyEntity>>> getAssetsGeography(GetAssetsGeographyParams params);

}
    