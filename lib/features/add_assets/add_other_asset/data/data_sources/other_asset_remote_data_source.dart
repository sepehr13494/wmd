import 'package:flutter/material.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

abstract class OtherAssetRemoteDataSource {
  Future<AddAssetModel> postOtherAsset(AddOtherAssetParams addOtherAssetParams);
}

class OtherAssetRemoteDataSourceImpl extends AppServerDataSource
    implements OtherAssetRemoteDataSource {
  OtherAssetRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AddAssetModel> postOtherAsset(
      AddOtherAssetParams addOtherAssetParams) async {
    final tPostSaveRequestOptions = AppRequestOptions(RequestTypes.post,
        AppUrls.postOtherAsset, addOtherAssetParams.toJson());

    final response =
        await errorHandlerMiddleware.sendRequest(tPostSaveRequestOptions);
    final result = AddAssetModel.fromJson(response);

    return result;
  }
}
