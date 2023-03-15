import '../../domain/entities/get_asset_class_entity.dart';

class GetAssetClassResponse  extends GetAssetClassEntity{
    GetAssetClassResponse();

    factory GetAssetClassResponse.fromJson(Map<String, dynamic> json) => GetAssetClassResponse(
    );
    
    static final tResponse = [GetAssetClassResponse()];
}
    