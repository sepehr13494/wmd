import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_allocation_params.dart';
import '../entities/get_allocation_entity.dart';
import '../../data/models/get_geographic_params.dart';
import '../entities/get_geographic_entity.dart';
import '../../data/models/get_pie_params.dart';
import '../entities/get_pie_entity.dart';


abstract class DashboardChartsRepository {
  Future<Either<Failure, List<GetAllocationEntity>>> getAllocation(GetAllocationParams params);
  Future<Either<Failure, List<GetGeographicEntity>>> getGeographic(GetGeographicParams params);
  Future<Either<Failure, List<GetPieEntity>>> getPie(GetPieParams params);

}
    