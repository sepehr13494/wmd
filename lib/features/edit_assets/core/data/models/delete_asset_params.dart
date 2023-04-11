import 'package:equatable/equatable.dart';

class DeleteAssetParams extends Equatable{
  final String assetId;
  const DeleteAssetParams({required this.assetId});

  factory DeleteAssetParams.fromJson(Map<String, dynamic> json) => DeleteAssetParams(
    assetId: json["assetId"],
  );

  Map<String, dynamic> toJson() => {
    "assetId":assetId,
  };

  @override
  List<Object?> get props => [
    assetId,
  ];
}