import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/set_number_params.dart';

import '../repositories/personal_information_repository.dart';

class SetNumberUseCase extends UseCase<AppSuccess, Map<String,dynamic>> {
  final PersonalInformationRepository repository;

  SetNumberUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(Map<String,dynamic> params) async {
    try{
      final map = SetNumberParams(countryCode: "+${params["country"]["phoneCode"]}", phoneNumber: params["phoneNumber"]);
      return await repository.setNumber(map);
    } catch (e){
      return Left(AppFailure(message: e.toString()));
    }
  }
}
      

    