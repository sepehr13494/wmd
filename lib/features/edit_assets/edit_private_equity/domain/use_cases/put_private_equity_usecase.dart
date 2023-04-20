import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';

import '../../data/models/put_private_equity_params.dart';

import '../repositories/edit_private_equity_repository.dart';

class PutPrivateEquityUseCase {
  final EditPrivateEquityRepository repository;
  final LocalStorage localStorage;

  PutPrivateEquityUseCase(this.repository, this.localStorage);
  
  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params,String assetId) async {
    try {
      return await repository.putPrivateEquity(PutPrivateEquityParams(assetId: assetId,addPrivateEquityParams: AddPrivateEquityUseCase.getAddPrivateEquityObj(params,localStorage)));
    } catch (e) {
      debugPrint("PutPrivateEquityUseCase catch : ${e.toString()}");
      if(e is TypeError){
        debugPrint(e.stackTrace.toString());
      }
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}
      

    