import '../../../data/models/base_performance_params.dart';

class GetClientIndexParams extends BasePerformanceParams{

    const GetClientIndexParams({required super.period});

    static const tParams = GetClientIndexParams(period: "ITD");


}