import 'package:equatable/equatable.dart';

class DeleteCustodianBankStatusParams extends Equatable {
  const DeleteCustodianBankStatusParams({
    required this.id,
  });

  final String? id;

  factory DeleteCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      DeleteCustodianBankStatusParams(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };

  @override
  List<Object?> get props => [
        id,
      ];

  static const tResponse = {
    "id": "hsbc",
  };
}
