import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/perform_logout_params.dart';



abstract class LogoutRepository {
  Future<Either<Failure, AppSuccess>> performLogout(PerformLogoutParams params);

}
    