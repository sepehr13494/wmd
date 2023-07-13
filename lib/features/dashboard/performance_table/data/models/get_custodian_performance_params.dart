import 'package:wmd/features/dashboard/performance_table/data/models/base_performance_params.dart';

class GetCustodianPerformanceParams extends BasePerformanceParams{

    const GetCustodianPerformanceParams({required super.period});

    static const tParams = GetCustodianPerformanceParams(period: "ITD");
}
    