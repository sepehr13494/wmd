import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';

class PutRealEstateParams extends Equatable {
  final String assetId;
  final AddRealEstateParams addRealEstateParams;

  const PutRealEstateParams({
    required this.assetId,
    required this.addRealEstateParams,
  });

  factory PutRealEstateParams.fromJson(Map<String, dynamic> json) =>
      PutRealEstateParams(
          assetId: json["assetId"],
        addRealEstateParams: AddRealEstateParams.fromJson(json["addRealEstateParams"])
      );

  Map<String, dynamic> toJson() => {
    "assetId":assetId,
    "addRealEstateParams":addRealEstateParams.toJson()
  };

  @override
  List<Object?> get props => [
    assetId,
    addRealEstateParams,
  ];

  static final tParams = PutRealEstateParams(assetId: "1234",addRealEstateParams: AddRealEstateParams.tAddRealEstateParams);
}
