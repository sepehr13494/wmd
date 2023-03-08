import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_force_update_params.dart';
import '../entities/get_force_update_entity.dart';


abstract class ForceUpdateRepository {
  Future<Either<Failure, GetForceUpdateEntity>> getForceUpdate(GetForceUpdateParams params);

}
    