import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/profile/personal_information/domain/entities/user_mandata_entity.dart';

import '../repositories/personal_information_repository.dart';

class GetUserMandataUseCase extends UseCase<List<UserMandateEntity>, NoParams> {
  final PersonalInformationRepository repository;

  GetUserMandataUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserMandateEntity>>> call(NoParams params) =>
      repository.getUserMandate(params);
}
