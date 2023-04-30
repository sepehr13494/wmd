

import 'package:wmd/core/data/models/no_data_response.dart';

class PutBankManualResponse extends NoDataResponse{
    const PutBankManualResponse();

    factory PutBankManualResponse.fromJson(Map<String, dynamic> json) => PutBankManualResponse();
    
    static const tResponse = PutBankManualResponse();

}
    