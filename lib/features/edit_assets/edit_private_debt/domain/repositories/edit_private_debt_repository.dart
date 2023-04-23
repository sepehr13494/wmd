import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/put_private_debt_params.dart';

import '../../data/models/delete_private_debt_params.dart';



abstract class EditPrivateDebtRepository {
  Future<Either<Failure, AppSuccess>> putPrivateDebt(PutPrivateDebtParams params);
  Future<Either<Failure, AppSuccess>> deletePrivateDebt(DeletePrivateDebtParams params);

}
    