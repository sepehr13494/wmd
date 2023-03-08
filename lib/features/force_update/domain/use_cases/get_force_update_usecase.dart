import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:package_info_plus/package_info_plus.dart';


import '../../data/models/get_force_update_params.dart';
import '../entities/get_force_update_entity.dart';
import '../repositories/force_update_repository.dart';

class GetForceUpdateUseCase extends UseCase<GetForceUpdateEntity, NoParams> {
  final ForceUpdateRepository repository;
  final PackageInfo packageInfo;

  GetForceUpdateUseCase(this.repository, this.packageInfo);
  
  @override
  Future<Either<Failure, GetForceUpdateEntity>> call(NoParams params) {

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return repository.getForceUpdate(GetForceUpdateParams(versionNumber: buildNumber,versionName: version));
  }
}
      

    