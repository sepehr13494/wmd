import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

import '../../data/models/put_bank_manual_params.dart';

import '../repositories/edit_bank_manual_repository.dart';

class PutBankManualUseCase{
  final EditBankManualRepository repository;
  final LocalStorage localStorage;

  PutBankManualUseCase(this.repository, this.localStorage);

  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params,String assetId) async {
    try {
      return await repository.putBankManual(PutBankManualParams(assetId: assetId,bankSaveParams: PostBankDetailsUseCase.getBankSaveParamObj(params,localStorage)));
    } catch (e) {
      debugPrint("PutBankManualUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}
      

    