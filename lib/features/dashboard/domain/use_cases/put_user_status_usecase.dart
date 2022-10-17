import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/data/models/user_status.dart';
import 'package:wmd/features/dashboard/domain/repositories/dashboard_repository.dart';

class PutUserStatusUseCase extends UseCase<UserStatus, UserStatus> {
  final DashboardRepository dashboardRepository;

  PutUserStatusUseCase(this.dashboardRepository);
  @override
  Future<Either<Failure, UserStatus>> call(UserStatus params) =>
      dashboardRepository.putUserStatus(params);
}
