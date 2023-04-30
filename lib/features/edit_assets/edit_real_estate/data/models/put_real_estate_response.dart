

import 'package:wmd/core/data/models/no_data_response.dart';

class PutRealEstateResponse extends NoDataResponse{
    PutRealEstateResponse();

    factory PutRealEstateResponse.fromJson(Map<String, dynamic> json) => PutRealEstateResponse(
    );
    
    static final tResponse = PutRealEstateResponse();
}
    