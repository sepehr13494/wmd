import '../../domain/entities/update_valuation_entity.dart';

class UpdateValuationResponse  extends UpdateValuationEntity{
    UpdateValuationResponse();

    factory UpdateValuationResponse.fromJson(Map<String, dynamic> json) => UpdateValuationResponse(
    );
    
    static final tResponse = UpdateValuationResponse();
}
    