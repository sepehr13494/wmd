import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_name_params.dart';
import '../models/get_name_response.dart';
import '../models/set_name_params.dart';
import '../models/set_name_response.dart';
import '../models/set_number_params.dart';
import '../models/set_number_response.dart';



abstract class PersonalInformationRemoteDataSource {
  Future<GetNameResponse> getName(GetNameParams params);
  Future<SetNameResponse> setName(SetNameParams params);
  Future<SetNumberResponse> setNumber(SetNumberParams params);

}

class PersonalInformationRemoteDataSourceImpl extends AppServerDataSource
    implements PersonalInformationRemoteDataSource {
  PersonalInformationRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<GetNameResponse> getName(GetNameParams params) async {
    final appRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getName, params.toJson());
    final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = GetNameResponse.fromJson(response);
    return result;
  }
  
      @override
  Future<SetNameResponse> setName(SetNameParams params) async {
      try{
        final appRequestOptions =
        AppRequestOptions(RequestTypes.put, AppUrls.setName, params.toJson());
        final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
        final result = SetNameResponse();
        return result;
      } on ServerException{
        rethrow;
      } catch (e){
        throw AppException(message: "format exception",data: e,type: ExceptionType.format);
      }

  }

  @override
  Future<SetNumberResponse> setNumber(SetNumberParams params) async {
    final appRequestOptions =
    AppRequestOptions(RequestTypes.get, AppUrls.setNumber, params.toJson());
    final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = SetNumberResponse.fromJson(response);
    return result;
  }
  
    
}
