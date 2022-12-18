import '../../domain/entities/get_chart_entity.dart';

class GetChartResponse  extends GetChartEntity{
    GetChartResponse();

    factory GetChartResponse.fromJson(Map<String, dynamic> json) => GetChartResponse(
    );
    
    static final tResponse = [GetChartResponse()];
}
    