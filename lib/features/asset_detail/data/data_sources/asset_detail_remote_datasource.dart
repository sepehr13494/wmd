import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/features/asset_detail/data/models/asset/bank_account_response.dart';
import 'package:wmd/features/asset_detail/domain/entities/assets/bank_account_entity.dart';

import '../models/get_detail_params.dart';
import '../models/get_detail_response.dart';

abstract class AssetDetailRemoteDataSource {
  Future<GetDetailResponse> getDetail(GetDetailParams params);
}

class AssetDetailRemoteDataSourceImpl extends AppServerDataSource
    implements AssetDetailRemoteDataSource {
  AssetDetailRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<GetDetailResponse> getDetail(GetDetailParams params) async {
    late final String url;
    switch (params.type) {
      case 'BankAccount':
        url = AppUrls.getBankAccount;
        break;
      case 'PrivateDept':
        url = AppUrls.getPrivateDept;
        break;
      case 'PrivateEquity':
        url = AppUrls.getPrivateEquity;
        break;
      case 'ListedAsset':
        url = AppUrls.getListedAsset;
        break;
      case 'OtherAsset':
        url = AppUrls.getOtherAsset;
        break;
      case 'RealEstate':
        url = AppUrls.getRealEstate;
        break;
      default:
        throw AppException(message: 'Unkonwn type');
    }

    final appRequestOptions =
        AppRequestOptions(RequestTypes.get, url, {'assetId': params.assetId});
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);

    switch (params.type) {
      case 'BankAccount':
      // return BankAccountResponse.fromJson(response);
      case 'PrivateDept':
      case 'PrivateEquity':
      case 'ListedAsset':
      case 'OtherAsset':
      case 'RealEstate':
        return GetDetailResponse.fromJson(response);
      default:
        throw AppException(message: 'Unkonwn type');
    }
  }
}
