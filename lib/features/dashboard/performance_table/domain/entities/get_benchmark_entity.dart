import 'package:equatable/equatable.dart';

class GetBenchmarkEntity extends Equatable {
    const GetBenchmarkEntity({
        required this.index,
        this.performance,
        this.performancePa,
        this.riskPa,
        this.sharpeRatio,
    });

    final String index;
    final double? performance;
    final double? performancePa;
    final double? riskPa;
    final double? sharpeRatio;

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
    