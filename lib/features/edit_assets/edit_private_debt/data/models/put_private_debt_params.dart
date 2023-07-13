import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';

class PutPrivateDebtParams extends Equatable{
    final String assetId;
    final AddPrivateDebtParams addPrivateDebtParams;

    const PutPrivateDebtParams({
        required this.assetId,
        required this.addPrivateDebtParams,
    });

    factory PutPrivateDebtParams.fromJson(Map<String, dynamic> json) =>
        PutPrivateDebtParams(
            assetId: json["assetId"],
            addPrivateDebtParams: AddPrivateDebtParams.fromJson(json["addPrivateDebtParams"])
        );

    Map<String, dynamic> toJson() => {
        "assetId":assetId,
        "addPrivateEquityParams":addPrivateDebtParams.toJson()
    };

    Map<String, dynamic> toServerJson() => {
        "assetId":assetId,
        ...addPrivateDebtParams.toJson(),
    };

    @override
    List<Object?> get props => [
        assetId,
        addPrivateDebtParams,
    ];

    static final tParams = PutPrivateDebtParams(assetId: "1234",addPrivateDebtParams: AddPrivateDebtParams.tAddPrivateDebtParams);
}
    