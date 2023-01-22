import 'dart:developer';

import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_see_more/real_estate/presentation/page/data/model/real_estate_more_entity.dart';

import '../models/get_asset_see_more_params.dart';
import '../models/get_asset_see_more_response.dart';

abstract class AssetSeeMoreRemoteDataSource {
  Future<GetSeeMoreResponse> getAssetSeeMore(GetSeeMoreParams params);
}

class AssetSeeMoreRemoteDataSourceImpl extends AppServerDataSource
    implements AssetSeeMoreRemoteDataSource {
  AssetSeeMoreRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<GetSeeMoreResponse> getAssetSeeMore(GetSeeMoreParams params) async {
    String type = params.type;
    type = AssetTypes.realEstate;
    try {
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getSeeMore(type), {
        'assetId': params.assetId,
      });
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      late final GetSeeMoreResponse result;

      switch (type) {
        case AssetTypes.realEstate:
          result = RealEstateMoreEntity.fromJson(response);
          break;
        default:
          // result = RealEstateMoreEntity.fromJson(response);
          result = DefaultMoreEntity(response.toString());
      }
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      log('Format erro detail: $e');
      throw const AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
