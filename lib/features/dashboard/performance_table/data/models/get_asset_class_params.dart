
import 'package:wmd/features/dashboard/performance_table/data/models/base_performance_params.dart';

class GetAssetClassParams extends BasePerformanceParams{

    const GetAssetClassParams({required super.period});

    static const tParams = GetAssetClassParams(period: "Last7Days");


}
    