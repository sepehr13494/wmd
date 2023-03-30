import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/post_valuation_params.dart';
import '../entities/post_valuation_entity.dart';
import '../../data/models/update_valuation_params.dart';
import '../entities/update_valuation_entity.dart';

abstract class AssetValuationRepository {
  Future<Either<Failure, AppSuccess>> postValuation(PostValuationParams params);
  Future<Either<Failure, UpdateValuationEntity>> updateValuation(
      UpdateValuationParams params);
}
