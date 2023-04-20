import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/put_private_equity_params.dart';

import '../../data/models/delete_private_equity_params.dart';



abstract class EditPrivateEquityRepository {
  Future<Either<Failure, AppSuccess>> putPrivateEquity(PutPrivateEquityParams params);
  Future<Either<Failure, AppSuccess>> deletePrivateEquity(DeletePrivateEquityParams params);

}
    