import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_custodian_bank_list_params.dart';
import '../entities/get_custodian_bank_list_entity.dart';
import '../../data/models/post_custodian_bank_status_params.dart';
import '../entities/post_custodian_bank_status_entity.dart';
import '../../data/models/get_custodian_bank_status_params.dart';
import '../entities/get_custodian_bank_status_entity.dart';


abstract class CustodianBankAuthRepository {
  Future<Either<Failure, List<GetCustodianBankListEntity>>> getCustodianBankList(GetCustodianBankListParams params);
  Future<Either<Failure, PostCustodianBankStatusEntity>> postCustodianBankStatus(PostCustodianBankStatusParams params);
  Future<Either<Failure, GetCustodianBankStatusEntity>> getCustodianBankStatus(GetCustodianBankStatusParams params);

}
    