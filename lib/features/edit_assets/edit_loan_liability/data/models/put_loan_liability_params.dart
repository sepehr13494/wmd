import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';

class PutLoanLiabilityParams extends Equatable{
    final String assetId;
    final AddLoanLiabilityParams addLoanLiabilityParams;

    const PutLoanLiabilityParams({
        required this.assetId,
        required this.addLoanLiabilityParams,
    });

    factory PutLoanLiabilityParams.fromJson(Map<String, dynamic> json) =>
        PutLoanLiabilityParams(
            assetId: json["assetId"],
            addLoanLiabilityParams: AddLoanLiabilityParams.fromJson(json["addLoanLiabilityParams"])
        );

    Map<String, dynamic> toJson() => {
        "assetId":assetId,
        "addLoanLiabilityParams":addLoanLiabilityParams.toJson()
    };

    Map<String, dynamic> toServerJson() => {
        "assetId":assetId,
        ...addLoanLiabilityParams.toJson(),
    };

    @override
    List<Object?> get props => [
        assetId,
        addLoanLiabilityParams,
    ];

    static final tParams = PutLoanLiabilityParams(assetId: "1234",addLoanLiabilityParams: AddLoanLiabilityParams.tAddLoanLiabilityParams);

}
    