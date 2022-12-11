import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_name_params.dart';
import '../entities/get_name_entity.dart';
import '../repositories/personal_information_repository.dart';

class GetNameUseCase extends UseCase<GetNameEntity, GetNameParams> {
  final PersonalInformationRepository repository;

  GetNameUseCase(this.repository);
  
  @override
  Future<Either<Failure, GetNameEntity>> call(GetNameParams params) =>
      repository.getName(params);
}
      

    