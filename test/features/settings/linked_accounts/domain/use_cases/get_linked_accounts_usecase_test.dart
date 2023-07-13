import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_params.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_response.dart';
import 'package:wmd/features/settings/linked_accounts/domain/use_cases/get_linked_accounts_usecase.dart';


import '../../data/repositories/linked_accounts_repository_impl_test.mocks.dart';




void main() {
  late GetLinkedAccountsUseCase getLinkedAccountsUseCase;
  late MockLinkedAccountsRepository mockLinkedAccountsRepository;

  setUp(() {
    mockLinkedAccountsRepository = MockLinkedAccountsRepository();
    getLinkedAccountsUseCase = GetLinkedAccountsUseCase(mockLinkedAccountsRepository);
  });

  test('should get GetLinkedAccountsEntity from the repository', () async {
    //arrange
    when(mockLinkedAccountsRepository.getLinkedAccounts(any))
        .thenAnswer((_) async => Right(GetLinkedAccountsResponse.tResponse));
    // act
    final result = await getLinkedAccountsUseCase(GetLinkedAccountsParams.tParams);

    // assert
    expect(result, equals(Right(GetLinkedAccountsResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockLinkedAccountsRepository.getLinkedAccounts(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getLinkedAccountsUseCase(GetLinkedAccountsParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockLinkedAccountsRepository.getLinkedAccounts(GetLinkedAccountsParams.tParams));
    },
  );
}

    