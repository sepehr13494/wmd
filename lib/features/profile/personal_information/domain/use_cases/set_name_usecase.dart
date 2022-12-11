import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/set_name_params.dart';

import '../repositories/personal_information_repository.dart';

class SetNameUseCase extends UseCase<AppSuccess, SetNameParams> {
  final PersonalInformationRepository repository;

  SetNameUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(SetNameParams params) =>
      repository.setName(params);
}
      

    