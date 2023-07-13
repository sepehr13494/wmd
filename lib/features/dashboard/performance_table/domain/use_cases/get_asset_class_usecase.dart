import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_asset_class_params.dart';
import '../entities/get_asset_class_entity.dart';
import '../repositories/performance_table_repository.dart';

class GetAssetClassUseCase extends UseCase<List<GetAssetClassEntity>, GetAssetClassParams> {
  final PerformanceTableRepository repository;

  GetAssetClassUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetAssetClassEntity>>> call(GetAssetClassParams params) =>
      repository.getAssetClass(params);
}
      

    