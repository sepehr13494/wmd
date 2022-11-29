import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/repository/plaid_repository.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';

class PlaidUseCase extends UseCase<String, BankEntity> {
  final PlaidRepository plaidLinkRepository;

  PlaidUseCase(this.plaidLinkRepository);

  static const redirectUrl = 'app://wmd.com';

  @override
  Future<Either<Failure, String>> call(BankEntity params) async {
    if (params.provider == null) {
      return const Left(AppFailure(message: 'Unknown provider'));
    }
    final linkTokenResult =
        await plaidLinkRepository.getLinkToken(redirectUrl, params.provider!);
    if (linkTokenResult.isLeft()) return linkTokenResult;
    final linkToken = linkTokenResult.fold((l) => null, (r) => r);
    final publicTokenResult =
        await plaidLinkRepository.getPublicToken(linkToken!);
    if (publicTokenResult.isLeft()) return publicTokenResult;
    final publicToken = publicTokenResult.fold((l) => null, (r) => r);
    return await plaidLinkRepository.postPublicToken(publicToken!);
  }
}
