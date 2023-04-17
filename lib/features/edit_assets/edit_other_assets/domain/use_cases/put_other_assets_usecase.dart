import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';

import '../../data/models/put_other_assets_params.dart';

import '../repositories/edit_other_assets_repository.dart';

class PutOtherAssetsUseCase{
  final EditOtherAssetsRepository repository;

  PutOtherAssetsUseCase(this.repository);
  
  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params,String assetId) async {
    try {
      return await repository.putOtherAssets(PutOtherAssetsParams(assetId: assetId,addOtherAssetParams: AddOtherAssetUseCase.getAddOtherAssetObj(params)));
    } catch (e) {
      debugPrint("PutOtherAssetsUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}
      

    