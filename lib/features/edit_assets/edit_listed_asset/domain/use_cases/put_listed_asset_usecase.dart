import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';

import '../../data/models/put_listed_asset_params.dart';

import '../repositories/edit_listed_asset_repository.dart';

class PutListedAssetUseCase {
  final EditListedAssetRepository repository;

  PutListedAssetUseCase(this.repository);
  
  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params,String assetId) async {
    try {
      return await repository.putListedAsset(PutListedAssetParams(assetId: assetId,addListedSecurityParams: AddListedSecurityUseCase.getAddListedSecurityParamsObj(params)));
    } catch (e) {
      debugPrint("PutListedAssetUseCase catch : ${e.toString()}");
      if(e is TypeError){
        debugPrint(e.stackTrace.toString());
      }
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}
      

    