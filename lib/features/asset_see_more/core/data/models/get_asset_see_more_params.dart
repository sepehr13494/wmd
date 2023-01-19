import 'package:equatable/equatable.dart';

class GetSeeMoreParams extends Equatable {
  final String type;
  final String assetId;
  const GetSeeMoreParams({
    required this.type,
    required this.assetId,
  });

  Map<String, dynamic> toJson() => {
        type: type,
      };

  @override
  List<Object?> get props => [type];

  static const tParams = GetSeeMoreParams(type: 'BankAccount', assetId: 'id');
}
