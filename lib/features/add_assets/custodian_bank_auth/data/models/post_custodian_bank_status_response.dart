import '../../domain/entities/post_custodian_bank_status_entity.dart';

class PostCustodianBankStatusResponse extends PostCustodianBankStatusEntity {
  final bool success;
  const PostCustodianBankStatusResponse({required this.success});

  factory PostCustodianBankStatusResponse.fromJson(Map<String, dynamic> json) =>
      PostCustodianBankStatusResponse(success: json['success']);
}
