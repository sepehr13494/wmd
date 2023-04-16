import 'package:wmd/features/dashboard/performance_table/data/models/base_performance_params.dart';

class GetBenchmarkParams extends BasePerformanceParams{

    const GetBenchmarkParams({required super.period});

    static const tParams = GetBenchmarkParams(period: "Last7Days");

}
    