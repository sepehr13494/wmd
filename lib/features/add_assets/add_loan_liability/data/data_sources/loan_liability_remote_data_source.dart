import 'package:flutter/material.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

abstract class LoanLiabilityRemoteDataSource {
  Future<AddAssetModel> postLoanLiability(
      AddLoanLiabilityParams addLoanLiabilityParams);
}

class LoanLiabilityRemoteDataSourceImpl extends AppServerDataSource
    implements LoanLiabilityRemoteDataSource {
  LoanLiabilityRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AddAssetModel> postLoanLiability(
      AddLoanLiabilityParams addLoanLiabilityParams) async {
    final tPostRequestOptions = AppRequestOptions(RequestTypes.post,
        AppUrls.postLoanLiability, addLoanLiabilityParams.toJson());

    final response =
        await errorHandlerMiddleware.sendRequest(tPostRequestOptions);

    final result = AddAssetModel.fromJson(response);

    return result;
  }
}
