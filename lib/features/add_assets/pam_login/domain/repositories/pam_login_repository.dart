import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/get_mandates_params.dart';

import '../../data/models/login_pam_account_params.dart';

abstract class PamLoginRepository {
  Future<Either<Failure, AppSuccess>> getMandates(GetMandatesParams params);
  Future<Either<Failure, AppSuccess>> loginPamAccount(
      LoginPamAccountParams params);
}
