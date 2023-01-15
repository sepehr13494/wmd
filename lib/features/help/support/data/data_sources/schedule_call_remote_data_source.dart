import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_schedule_call_usecase.dart';

abstract class ScheduleCallRemoteDataSource {
  Future<SupportStatus> postScheduleCall(ScheduleCallParams params);
}

class ScheduleCallRemoteDataSourceImpl extends AppServerDataSource
    implements ScheduleCallRemoteDataSource {
  ScheduleCallRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<SupportStatus> postScheduleCall(ScheduleCallParams params) async {
    final getUserStatusRequestOptions = AppRequestOptions(
        RequestTypes.post, AppUrls.postScheduleCall, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(getUserStatusRequestOptions);
    final result = SupportStatus();
    return result;
  }
}
