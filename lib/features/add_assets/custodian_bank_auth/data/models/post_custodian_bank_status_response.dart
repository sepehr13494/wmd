import '../../domain/entities/post_custodian_bank_status_entity.dart';

class PostCustodianBankStatusResponse extends PostCustodianBankStatusEntity {
  const PostCustodianBankStatusResponse({required super.id});

  factory PostCustodianBankStatusResponse.fromId(String id) =>
      PostCustodianBankStatusResponse(id: id);
}
