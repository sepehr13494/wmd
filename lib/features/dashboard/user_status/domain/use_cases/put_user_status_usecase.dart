import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/user_status_repository.dart';

class PutUserStatusUseCase extends UseCase<UserStatus, UserStatus> {
  final UserStatusRepository dashboardRepository;

  PutUserStatusUseCase(this.dashboardRepository);
  @override
  Future<Either<Failure, UserStatus>> call(UserStatus params) =>
      dashboardRepository.putUserStatus(params);
}
