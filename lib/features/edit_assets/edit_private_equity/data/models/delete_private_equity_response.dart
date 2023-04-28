

import 'package:wmd/core/data/models/no_data_response.dart';

class DeletePrivateEquityResponse extends NoDataResponse{
    DeletePrivateEquityResponse();

    factory DeletePrivateEquityResponse.fromJson(Map<String, dynamic> json) => DeletePrivateEquityResponse(
    );
    
    static final tResponse = DeletePrivateEquityResponse();
}
    