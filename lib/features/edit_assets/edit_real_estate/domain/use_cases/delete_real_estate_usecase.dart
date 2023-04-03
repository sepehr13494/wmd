import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_real_estate_params.dart';

import '../repositories/edit_real_estate_repository.dart';

class DeleteRealEstateUseCase extends UseCase<AppSuccess, DeleteRealEstateParams> {
  final EditRealEstateRepository repository;

  DeleteRealEstateUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeleteRealEstateParams params) =>
      repository.deleteRealEstate(params);
}
      

    