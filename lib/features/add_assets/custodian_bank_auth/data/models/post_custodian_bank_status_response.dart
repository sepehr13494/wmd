import '../../domain/entities/post_custodian_bank_status_entity.dart';

class PostCustodianBankStatusResponse extends PostCustodianBankStatusEntity {
  const PostCustodianBankStatusResponse(super.success);

  factory PostCustodianBankStatusResponse.fromJson(bool resp) =>
      PostCustodianBankStatusResponse(resp);
}
