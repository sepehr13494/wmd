import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';

class PutListedAssetParams extends Equatable{
    final String assetId;
    final AddListedSecurityParams addListedSecurityParams;

    const PutListedAssetParams({
        required this.assetId,
        required this.addListedSecurityParams,
    });

    factory PutListedAssetParams.fromJson(Map<String, dynamic> json) =>
        PutListedAssetParams(
            assetId: json["assetId"],
            addListedSecurityParams: AddListedSecurityParams.fromJson(json["addListedSecurityParams"])
        );

    Map<String, dynamic> toJson() => {
        "assetId":assetId,
        "addListedSecurityParams":addListedSecurityParams.toJson()
    };

    @override
    List<Object?> get props => [
        assetId,
        addListedSecurityParams,
    ];

    static final tParams = PutListedAssetParams(assetId: "1234",addListedSecurityParams: AddListedSecurityParams.tAddListedSecurityParams);

}
    