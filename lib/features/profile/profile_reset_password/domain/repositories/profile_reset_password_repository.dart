import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/reset_params.dart';



abstract class ProfileResetPasswordRepository {
  Future<Either<Failure, AppSuccess>> reset(ResetParams params);

}
    