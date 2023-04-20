import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';

class PutPrivateEquityParams extends Equatable {
  final String assetId;
  final AddPrivateEquityParams addPrivateEquityParams;

  const PutPrivateEquityParams({
    required this.assetId,
    required this.addPrivateEquityParams,
  });

  factory PutPrivateEquityParams.fromJson(Map<String, dynamic> json) =>
      PutPrivateEquityParams(
          assetId: json["assetId"],
          addPrivateEquityParams: AddPrivateEquityParams.fromJson(json["addPrivateEquityParams"])
      );

  Map<String, dynamic> toJson() => {
    "assetId":assetId,
    "addPrivateEquityParams":addPrivateEquityParams.toJson()
  };

  @override
  List<Object?> get props => [
    assetId,
    addPrivateEquityParams,
  ];

  static final tParams = PutPrivateEquityParams(assetId: "1234",addPrivateEquityParams: AddPrivateEquityParams.tAddPrivateEquityParams);
}
