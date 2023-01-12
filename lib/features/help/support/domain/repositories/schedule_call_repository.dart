import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_schedule_call_usecase.dart';

abstract class ScheduleCallRepository {
  Future<Either<Failure, AppSuccess>> postScheduleCall(
      ScheduleCallParams params);
}
