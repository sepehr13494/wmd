import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_summary_params.dart';
import 'package:wmd/features/asset_detail/core/domain/entities/asset_summary_entity.dart';

abstract class AssetSummaryRepository {
  Future<Either<Failure, AssetSummaryEntitiy>> getSummary(
      GetSummaryParams params);
}
