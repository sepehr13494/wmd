import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/request_new_custodian_params.dart';



abstract class RequestNewCustodianRepository {
  Future<Either<Failure, AppSuccess>> requestNewCustodian(RequestNewCustodianParams params);

}
    