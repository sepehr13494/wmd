

import 'package:wmd/core/data/models/no_data_response.dart';

class DeleteBankManualResponse extends NoDataResponse{
    DeleteBankManualResponse();

    factory DeleteBankManualResponse.fromJson(Map<String, dynamic> json) => DeleteBankManualResponse(
    );

    static final tResponse = DeleteBankManualResponse();
}
    