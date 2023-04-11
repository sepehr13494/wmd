import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/put_bank_manual_params.dart';

import '../../data/models/delete_bank_manual_params.dart';



abstract class EditBankManualRepository {
  Future<Either<Failure, AppSuccess>> putBankManual(PutBankManualParams params);
  Future<Either<Failure, AppSuccess>> deleteBankManual(DeleteBankManualParams params);

}
    