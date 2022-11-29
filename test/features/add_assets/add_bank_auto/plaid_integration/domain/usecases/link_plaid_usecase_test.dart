import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/repository/plaid_repository.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/usecase/plaid_usecase.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/bank_list_response.dart';

import 'link_plaid_usecase_test.mocks.dart';

@GenerateMocks([PlaidRepository])
void main() {
  late MockPlaidLinkRepository mockPlaidLinkRepository;
  late PlaidUseCase plaidLinkUseCase;

  setUp(() {
    mockPlaidLinkRepository = MockPlaidLinkRepository();
    plaidLinkUseCase = PlaidUseCase(mockPlaidLinkRepository);
  });

  group('plaidLink use case test', () {
    test('Should get postToken response', () async {
      const publicTokenResp = 'Public-token-response';
      const linkToken = 'Link-token';
      const publicToken = 'Public-token';
      final param = BankResponse.fromJson(BankResponse.tBankResponse);

      when(mockPlaidLinkRepository.getLinkToken(
              PlaidUseCase.redirectUrl, param.provider))
          .thenAnswer((_) async => const Right(linkToken));
      when(mockPlaidLinkRepository.getPublicToken(linkToken))
          .thenAnswer((_) async => const Right(publicToken));
      when(mockPlaidLinkRepository.postPublicToken(publicToken))
          .thenAnswer((_) async => const Right(publicTokenResp));

      final result = await plaidLinkUseCase.call(param);

      expect(result.fold((l) => l, (r) => r), publicTokenResp);
    });
  });
}
