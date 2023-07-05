import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_manual_list_params.dart';
import '../entities/get_manual_list_entity.dart';


abstract class ManualBankListRepository {
  Future<Either<Failure, List<GetManualListEntity>>> getManualList(GetManualListParams params);

}
    