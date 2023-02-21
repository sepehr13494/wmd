import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_assets_geography_params.dart';
import '../entities/get_assets_geography_entity.dart';
import '../repositories/assets_geography_chart_repository.dart';

class GetAssetsGeographyUseCase extends UseCase<List<GetAssetsGeographyEntity>, GetAssetsGeographyParams> {
  final AssetsGeographyChartRepository repository;

  GetAssetsGeographyUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetAssetsGeographyEntity>>> call(GetAssetsGeographyParams params) =>
      repository.getAssetsGeography(params);
}
      

    