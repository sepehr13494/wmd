import '../../domain/entities/get_custodian_performance_entity.dart';

class GetCustodianPerformanceResponse  extends GetCustodianPerformanceEntity{
    GetCustodianPerformanceResponse();

    factory GetCustodianPerformanceResponse.fromJson(Map<String, dynamic> json) => GetCustodianPerformanceResponse(
    );
    
    static final tResponse = [GetCustodianPerformanceResponse()];
}
    