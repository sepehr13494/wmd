import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';
import 'package:wmd/features/asset_detail/real_estate/data/models/real_estate_response.dart';

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

    try {
      switch (params.type) {
        case 'BankAccount':
          return BankAccountResponse.fromJson(response);
        case 'RealEstate':
          return RealEstateResponse.fromJson(response);
        case 'PrivateDept':
        case 'PrivateEquity':
        case 'ListedAsset':
        case 'OtherAsset':
          return GetDetailResponse.fromJson(response);
        default:
          throw AppException(message: 'Unkonwn type');
      }
    } catch (e) {
      throw AppException(
          message: 'Format exceptions', type: ExceptionType.format);
    }
  }
}
