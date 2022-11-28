import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
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
    final getUserStatusRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getUserNetWorth, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(getUserStatusRequestOptions);
    final result = NetWorthResponseObj.fromJson(response);
    return result;
  }
}
