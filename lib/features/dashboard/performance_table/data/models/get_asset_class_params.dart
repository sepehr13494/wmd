
import 'package:equatable/equatable.dart';

class GetAssetClassParams extends Equatable{
    const GetAssetClassParams({
        required this.period,
    });

    final String period;

    factory GetAssetClassParams.fromJson(Map<String, dynamic> json) => GetAssetClassParams(
        period: json["period"],
    );

    Map<String, dynamic> toJson() => {
        "period": period,
    };

    static const tParams = GetAssetClassParams(period: "Last7Days");

  @override
  List<Object?> get props => [period];
}
    