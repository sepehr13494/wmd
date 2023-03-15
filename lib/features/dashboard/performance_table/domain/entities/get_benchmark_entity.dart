import 'package:equatable/equatable.dart';

class GetBenchmarkEntity extends Equatable {
    const GetBenchmarkEntity({
        required this.index,
        required this.performance,
        required this.performancePa,
        required this.riskPa,
        required this.sharpeRatio,
    });

    final String index;
    final double performance;
    final int performancePa;
    final int riskPa;
    final double sharpeRatio;

    Map<String, dynamic> toJson() => {
        "index": index,
        "performance": performance,
        "performancePA": performancePa,
        "riskPA": riskPa,
        "sharpeRatio": sharpeRatio,
    };

    @override
    List<Object?> get props => [];
}
    