import '../../domain/entities/get_valuation_performance_entity.dart';

class GetValuationPerformanceResponse  extends GetValuationPerformanceEntity{
    GetValuationPerformanceResponse();

    factory GetValuationPerformanceResponse.fromJson(Map<String, dynamic> json) => GetValuationPerformanceResponse(
    );
    
    static final tResponse = [GetValuationPerformanceResponse()];
}
    