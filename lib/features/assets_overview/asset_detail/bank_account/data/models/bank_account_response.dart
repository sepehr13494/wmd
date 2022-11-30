import 'package:wmd/features/assets_overview/asset_detail/bank_account/domain/entities/bank_account_entity.dart';

class BankAccountResponse extends BankAccountEntity {
  BankAccountResponse(String assetId) : super(assetId);

  factory BankAccountResponse.fromJson(Map<String, dynamic> json) =>
      BankAccountResponse(json["assetsId"].toString());

  @override
  List<Object?> get props => [
        assetId,
      ];
}
