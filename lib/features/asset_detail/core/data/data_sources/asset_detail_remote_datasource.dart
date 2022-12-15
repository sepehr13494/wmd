import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';
import 'package:wmd/features/asset_detail/listed_asset/data/models/listed_asset_response.dart';
import 'package:wmd/features/asset_detail/private_debt/data/models/private_debt_response.dart';
import 'package:wmd/features/asset_detail/private_equity/data/models/private_equity_response.dart';
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
      case AssetTypes.bankAccount:
        url = AppUrls.getBankAccount;
        break;
      case AssetTypes.privateDebt:
        url = AppUrls.getPrivateDebt;
        break;
      case AssetTypes.privateEquity:
        url = AppUrls.getPrivateEquity;
        break;
      case AssetTypes.listedAsset:
        url = AppUrls.getListedAsset;
        break;
      case AssetTypes.otherAsset:
        url = AppUrls.getOtherAsset;
        break;
      case AssetTypes.realEstate:
        url = AppUrls.getRealEstate;
        break;
      default:
        throw AppException(message: 'Unkonwn type to get');
    }

    final appRequestOptions =
        AppRequestOptions(RequestTypes.get, url, {'assetId': params.assetId});
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);

    try {
      switch (params.type) {
        case AssetTypes.bankAccount:
          return BankAccountResponse.fromJson(response);
        case AssetTypes.realEstate:
          return RealEstateResponse.fromJson(response);
        case AssetTypes.privateEquity:
          return PrivateEquityResponse.fromJson(response);
        case AssetTypes.listedAsset:
          return ListedAssetResponse.fromJson(response);
        case AssetTypes.privateDebt:
          return PrivateDebtResponse.fromJson(response);
        default:
          return GetDetailResponse.fromJson(response);
        // throw AppException(message: 'Unkonwn type');
      }
    } catch (e) {
      throw AppException(
          message: 'Format exceptions', type: ExceptionType.format);
    }
  }
}
