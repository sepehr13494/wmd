import '../../domain/entities/get_benchmark_entity.dart';

class GetBenchmarkResponse  extends GetBenchmarkEntity{
    GetBenchmarkResponse();

    factory GetBenchmarkResponse.fromJson(Map<String, dynamic> json) => GetBenchmarkResponse(
    );
    
    static final tResponse = [GetBenchmarkResponse()];
}
    