import 'package:equatable/equatable.dart';

class BankAccountEntity extends Equatable {
  final String assetId;

  BankAccountEntity(this.assetId);

  Map<String, dynamic> toJson() => {
        "assetId": assetId,
      };

  @override
  List<Object?> get props => [
        assetId,
      ];
}
