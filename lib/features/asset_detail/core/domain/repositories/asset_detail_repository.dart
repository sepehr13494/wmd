import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_detail_params.dart';
import '../entities/get_detail_entity.dart';


abstract class AssetDetailRepository {
  Future<Either<Failure, GetDetailEntity>> getDetail(GetDetailParams params);

}
    