

import 'package:wmd/core/data/models/no_data_response.dart';

class DeleteListedAssetResponse extends NoDataResponse{
    DeleteListedAssetResponse();

    factory DeleteListedAssetResponse.fromJson(Map<String, dynamic> json) => DeleteListedAssetResponse(
    );
    
    static final tResponse = DeleteListedAssetResponse();
}
    