import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/put_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/status_entity.dart';

import '../../data/models/get_custodian_bank_list_params.dart';
import '../entities/custodian_bank_entity.dart';
import '../../data/models/post_custodian_bank_status_params.dart';
import '../entities/post_custodian_bank_status_entity.dart';
import '../../data/models/get_custodian_bank_status_params.dart';
import '../entities/get_custodian_bank_status_entity.dart';

abstract class CustodianBankAuthRepository {
  Future<Either<Failure, List<CustodianBankEntity>>> getCustodianBankList(
      GetCustodianBankListParams params);
  Future<Either<Failure, PostCustodianBankStatusEntity>>
      postCustodianBankStatus(PostCustodianBankStatusParams params);
  Future<Either<Failure, PostCustodianBankStatusEntity>> putCustodianBankStatus(
      PutCustodianBankStatusParams params);
  Future<Either<Failure, CustodianBankStatusEntity>> getCustodianBankStatus(
      GetCustodianBankStatusParams params);
  Future<Either<Failure, AppSuccess>> deleteCustodianBankStatus(
      DeleteCustodianBankStatusParams params);
  Future<Either<Failure, List<StatusEntity>>> getCustodianStatusList(
      GetCustodianBankListParams params);
}
