import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';

import '../../data/models/put_loan_liability_params.dart';

import '../repositories/edit_loan_liability_repository.dart';

class PutLoanLiabilityUseCase{
  final EditLoanLiabilityRepository repository;

  PutLoanLiabilityUseCase(this.repository);

  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params,String assetId) async {
    try {
      return await repository.putLoanLiability(PutLoanLiabilityParams(assetId: assetId,addLoanLiabilityParams: AddLoanLiabilityUseCase.getAddLoanLiabilityParamsObj(params)));
    } catch (e) {
      debugPrint("PutListedAssetUseCase catch : ${e.toString()}");
      if(e is TypeError){
        debugPrint(e.stackTrace.toString());
      }
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}
      

    