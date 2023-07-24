import 'package:equatable/equatable.dart';

class GetPortfolioAllocationParams extends Equatable{
    final String ownerId;

    const GetPortfolioAllocationParams({
        required this.ownerId,
    });

    factory GetPortfolioAllocationParams.fromJson(Map<String, dynamic> json) => GetPortfolioAllocationParams(
        ownerId: json["ownerId"],
    );

    Map<String, dynamic> toJson() => {
        "ownerId": ownerId,
    };

    @override
    List<Object?> get props => [
        ownerId,
    ];

    static const tParams = GetPortfolioAllocationParams(ownerId: "ownerId");
}
    