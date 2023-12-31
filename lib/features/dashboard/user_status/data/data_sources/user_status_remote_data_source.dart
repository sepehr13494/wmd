import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';

abstract class UserStatusRemoteDataSource {
  Future<UserStatus> getUserStatus(NoParams noParams);

  Future<UserStatus> putUserStatus(UserStatus userStatusParam);
}

class UserStatusRemoteDataSourceImpl extends AppServerDataSource
    implements UserStatusRemoteDataSource {
  UserStatusRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<UserStatus> getUserStatus(NoParams noParams) async {
    try {
      final getUserStatusRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getUserStatus, null);
      final response =
          await errorHandlerMiddleware.sendRequest(getUserStatusRequestOptions);
      final result = UserStatus.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<UserStatus> putUserStatus(UserStatus userStatusParam) async {
    try {
      final putUserStatusRequestOptions = AppRequestOptions(
        RequestTypes.put,
        AppUrls.getUserStatus,
        userStatusParam.toJson(),
      );
      final response =
          await errorHandlerMiddleware.sendRequest(putUserStatusRequestOptions);
      final result = UserStatus.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
