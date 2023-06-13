import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_mandate_status_params.dart';
import '../entities/get_mandate_status_entity.dart';


abstract class MandateStatusRepository {
  Future<Either<Failure, List<GetMandateStatusEntity>>> getMandateStatus(GetMandateStatusParams params);

}
    