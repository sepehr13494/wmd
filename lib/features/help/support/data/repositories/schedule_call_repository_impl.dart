import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/help/support/data/data_sources/schedule_call_remote_data_source.dart';
import 'package:wmd/features/help/support/domain/repositories/schedule_call_repository.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_schedule_call_usecase.dart';

class ScheduleCallRepositoryImpl implements ScheduleCallRepository {
  final ScheduleCallRemoteDataSource scheduleCallRemoteDataSource;

  ScheduleCallRepositoryImpl(this.scheduleCallRemoteDataSource);
  @override
  Future<Either<Failure, AppSuccess>> postScheduleCall(
      ScheduleCallParams params) async {
    try {
      final result =
          await scheduleCallRemoteDataSource.postScheduleCall(params);

      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message, type: error.type));
    }
  }
}
