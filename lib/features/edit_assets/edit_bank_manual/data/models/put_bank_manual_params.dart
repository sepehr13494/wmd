import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

class PutBankManualParams extends Equatable{
    final String assetId;
    final BankSaveParams bankSaveParams;

    const PutBankManualParams({
        required this.assetId,
        required this.bankSaveParams,
    });

    factory PutBankManualParams.fromJson(Map<String, dynamic> json) =>
        PutBankManualParams(
            assetId: json["assetId"],
            bankSaveParams: BankSaveParams.fromJson(json["bankSaveParams"])
        );

    Map<String, dynamic> toJson() => {
        "assetId":assetId,
        "bankSaveParams":bankSaveParams.toJson()
    };

    Map<String, dynamic> toServerJson() => {
        "assetId":assetId,
        ...bankSaveParams.toJson(),
    };

    @override
    List<Object?> get props => [
        assetId,
        bankSaveParams,
    ];

    static const tParams = PutBankManualParams(assetId: "1234",bankSaveParams: BankSaveParams.tBankSaveParams);
}
    