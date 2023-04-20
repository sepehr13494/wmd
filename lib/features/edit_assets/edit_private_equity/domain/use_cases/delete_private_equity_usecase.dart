import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_private_equity_params.dart';

import '../repositories/edit_private_equity_repository.dart';

class DeletePrivateEquityUseCase extends UseCase<AppSuccess, DeletePrivateEquityParams> {
  final EditPrivateEquityRepository repository;

  DeletePrivateEquityUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeletePrivateEquityParams params) =>
      repository.deletePrivateEquity(params);
}
      

    