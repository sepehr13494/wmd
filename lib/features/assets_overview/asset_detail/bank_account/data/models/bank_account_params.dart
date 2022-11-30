import 'package:equatable/equatable.dart';

class BankAccountParams extends Equatable {
  final String assetId;

  const BankAccountParams(this.assetId);

  Map<String, dynamic> toJson() => {
        "assetId": assetId,
      };

  @override
  List<Object?> get props => [assetId];
}
