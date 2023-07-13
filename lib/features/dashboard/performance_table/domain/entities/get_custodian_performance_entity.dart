import 'package:equatable/equatable.dart';

class GetCustodianPerformanceEntity extends Equatable {
    const GetCustodianPerformanceEntity({
        required this.serialNumber,
        required this.custodianName,
        required this.performance,
        required this.amount,
        required this.riskPa,
        required this.sharpeRatio,
    });

    final String serialNumber;
    final String custodianName;
    final double performance;
    final double amount;
    final double riskPa;
    final double sharpeRatio;



    Map<String, dynamic> toJson() => {
        "serialNumber": serialNumber,
        "custodianName": custodianName,
        "performance": performance,
        "amount": amount,
        "riskPA": riskPa,
        "sharpeRatio": sharpeRatio,
    };

    @override
    List<Object?> get props => [];
}
    