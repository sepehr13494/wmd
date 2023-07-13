

import 'package:wmd/core/data/models/no_data_response.dart';

class DeleteRealEstateResponse extends NoDataResponse{
    DeleteRealEstateResponse();

    factory DeleteRealEstateResponse.fromJson(Map<String, dynamic> json) => DeleteRealEstateResponse(
    );
    
    static final tResponse = DeleteRealEstateResponse();
}
    