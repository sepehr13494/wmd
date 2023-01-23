import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';
import 'package:wmd/features/add_assets/add_listed_security/data/models/listed_security_name.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/repositories/listed_security_repository.dart';

class GetListedSecurityUseCase
    extends UseCase<List<ListedSecurityName>, String> {
  final ListedSecurityRepository listedSecurityRepository;

  GetListedSecurityUseCase(this.listedSecurityRepository);

  List<BankEntity>? banks;

  @override
  Future<Either<Failure, List<ListedSecurityName>>> call(String params) async {
    // if (banks != null && banks!.isNotEmpty) {
    //   return Right(_filter(banks!, params));
    // } else {
    return await listedSecurityRepository.getListedSecurity(params);
    // _cache(temp);
    // return temp.bimap((l) => l, (r) => _filter(r, params));
    // }
  }

  // List<BankEntity> _filter(List<BankEntity> list, String text) {
  //   return list.where((e) => e.name.contains(text)).toList();
  // }

  // void _cache(Either<Failure, List<BankEntity>> temp) {
  //   temp.fold((l) => null, (r) {
  //     banks = List.from(r);
  //   });
  // }
}
