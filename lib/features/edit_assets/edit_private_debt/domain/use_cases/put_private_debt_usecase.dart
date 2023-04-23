import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';

import '../../data/models/put_private_debt_params.dart';

import '../repositories/edit_private_debt_repository.dart';

class PutPrivateDebtUseCase{
  final EditPrivateDebtRepository repository;
  final LocalStorage localStorage;

  PutPrivateDebtUseCase(this.repository, this.localStorage);
  
  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params,String assetId) async {
    try {
      return await repository.putPrivateDebt(PutPrivateDebtParams(assetId: assetId,addPrivateDebtParams: AddPrivateDebtUseCase.getAddPrivateDeptPramsObj(params,localStorage)));
    } catch (e) {
      debugPrint("PutPrivateDebtUseCase catch : ${e.toString()}");
      if(e is TypeError){
        debugPrint(e.stackTrace.toString());
      }
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}
      

    