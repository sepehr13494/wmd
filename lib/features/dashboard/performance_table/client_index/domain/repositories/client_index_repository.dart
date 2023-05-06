import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_client_index_params.dart';
import '../entities/get_client_index_entity.dart';


abstract class ClientIndexRepository {
  Future<Either<Failure, GetClientIndexEntity>> getClientIndex(GetClientIndexParams params);

}
    