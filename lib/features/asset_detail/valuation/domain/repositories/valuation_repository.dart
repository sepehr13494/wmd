import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/get_all_valuation_params.dart';
import '../entities/get_all_valuation_entity.dart';
import '../../data/models/post_valuation_params.dart';

import '../../data/models/get_valuation_performance_params.dart';
import '../entities/get_valuation_performance_entity.dart';


abstract class ValuationRepository {
  Future<Either<Failure, List<GetAllValuationEntity>>> getAllValuation(GetAllValuationParams params);
  Future<Either<Failure, AppSuccess>> postValuation(PostValuationParams params);
  Future<Either<Failure, List<GetValuationPerformanceEntity>>> getValuationPerformance(GetValuationPerformanceParams params);

}
    