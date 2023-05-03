import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_client_index_params.dart';
import '../entities/get_client_index_entity.dart';
import '../repositories/client_index_repository.dart';

class GetClientIndexUseCase extends UseCase<GetClientIndexEntity, GetClientIndexParams> {
  final ClientIndexRepository repository;

  GetClientIndexUseCase(this.repository);
  
  @override
  Future<Either<Failure, GetClientIndexEntity>> call(GetClientIndexParams params) =>
      repository.getClientIndex(params);
}
      

    