import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/profile/personal_information/domain/entities/user_mandata_entity.dart';

import '../../data/models/get_name_params.dart';
import '../entities/get_name_entity.dart';
import '../../data/models/set_name_params.dart';
import '../../data/models/set_number_params.dart';

abstract class PersonalInformationRepository {
  Future<Either<Failure, GetNameEntity>> getName(GetNameParams params);
  Future<Either<Failure, AppSuccess>> setName(SetNameParams params);
  Future<Either<Failure, AppSuccess>> setNumber(SetNumberParams params);
  Future<Either<Failure, List<UserMandateEntity>>> getUserMandate(
      NoParams params);
}
