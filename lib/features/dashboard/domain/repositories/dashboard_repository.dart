import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/data/models/user_status.dart';

abstract class DashboardRepository {
  Future<Either<Failure, UserStatus>> getUserStatus(NoParams noParams);
  Future<Either<Failure, UserStatus>> putUserStatus(UserStatus noParams);
}
