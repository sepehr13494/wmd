import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';

abstract class MainDashboardRemoteDataSource {
  Future<NetWorthResponseObj> userNetWorth(NetWorthParams params);
}

class MainDashboardRemoteDataSourceImpl extends AppServerDataSource
    implements MainDashboardRemoteDataSource {
  MainDashboardRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<NetWorthResponseObj> userNetWorth(NetWorthParams params) async {
    try {
      final getUserStatusRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getUserNetWorth, {
        "From": CustomizableDateTime.serverFormatDate(params.from!),
        "To":CustomizableDateTime.serverFormatDate(params.to!),
      });
      final response =
          await errorHandlerMiddleware.sendRequest(getUserStatusRequestOptions);
      final result = NetWorthResponseObj.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
