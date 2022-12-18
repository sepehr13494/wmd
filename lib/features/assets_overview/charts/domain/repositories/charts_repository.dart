import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_chart_params.dart';
import '../entities/get_chart_entity.dart';


abstract class ChartsRepository {
  Future<Either<Failure, List<GetChartEntity>>> getChart(GetChartParams params);

}
    