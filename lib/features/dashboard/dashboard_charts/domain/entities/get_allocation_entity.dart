import 'package:equatable/equatable.dart';

class GetAllocationEntity extends Equatable {
    const GetAllocationEntity({
        required this.name,
        required this.asset,
        required this.liability,
        required this.netWorth,
    });

    final String name;
    final double asset;
    final double liability;
    final double netWorth;

    Map<String, dynamic> toJson() => {
        "name": name,
        "asset": asset,
        "liability": liability,
        "netWorth": netWorth,
    };

    @override
    List<Object?> get props => [];
}
    