import '../../domain/entities/get_all_valuation_entity.dart';

class GetAllValuationResponse  extends GetAllValuationEntity{
    GetAllValuationResponse();

    factory GetAllValuationResponse.fromJson(Map<String, dynamic> json) => GetAllValuationResponse(
    );
    
    static final tResponse = [GetAllValuationResponse()];
}
    