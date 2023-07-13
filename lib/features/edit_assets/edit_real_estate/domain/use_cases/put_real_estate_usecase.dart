import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';

import '../../data/models/put_real_estate_params.dart';

import '../repositories/edit_real_estate_repository.dart';

class PutRealEstateUseCase {
  final EditRealEstateRepository repository;

  PutRealEstateUseCase(this.repository);
  
  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params,String assetId) async{
    try {
      return await repository.putRealEstate(PutRealEstateParams(assetId: assetId,addRealEstateParams: AddRealEstateUseCase.getAddRealStateObj(params)));
    } catch (e) {
      debugPrint("AddRealEstateUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}
      

    