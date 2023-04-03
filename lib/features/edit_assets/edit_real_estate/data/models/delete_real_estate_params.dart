import 'package:equatable/equatable.dart';

class DeleteRealEstateParams extends Equatable{
    final String assetId;
    const DeleteRealEstateParams({required this.assetId});

    factory DeleteRealEstateParams.fromJson(Map<String, dynamic> json) => DeleteRealEstateParams(
        assetId: json["assetId"],
    );

    Map<String, dynamic> toJson() => {
        "assetId":assetId,
    };

    @override
    List<Object?> get props => [];
    
    static const tParams = DeleteRealEstateParams(assetId: "1234");
}
    