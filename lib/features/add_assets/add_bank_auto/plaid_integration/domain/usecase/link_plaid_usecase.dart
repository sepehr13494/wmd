import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/repository/plaid_link_repository.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart';

class PlaidLinkUseCase extends UseCase<String, BankEntity> {
  final PlaidLinkRepository plaidLinkRepository;

  PlaidLinkUseCase(this.plaidLinkRepository);

  @override
  Future<Either<Failure, String>> call(BankEntity params) async {
    final linkTokenResult =
        await plaidLinkRepository.getLinkToken('redirectUrl');
    if (linkTokenResult.isRight()) {
      final publicToken = 'get public token with OAuth';
      final result = await plaidLinkRepository.postPublicToken(publicToken);
      return result;
    } else {
      return linkTokenResult;
    }
  }
}
