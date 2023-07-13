import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/put_real_estate_params.dart';

import '../../data/models/delete_real_estate_params.dart';



abstract class EditRealEstateRepository {
  Future<Either<Failure, AppSuccess>> putRealEstate(PutRealEstateParams params);
  Future<Either<Failure, AppSuccess>> deleteRealEstate(DeleteRealEstateParams params);

}
    