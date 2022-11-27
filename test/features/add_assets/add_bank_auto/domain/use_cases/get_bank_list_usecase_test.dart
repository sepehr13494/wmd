import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/data/models/bank_list_response.dart';
import 'package:wmd/features/add_assets/add_bank_auto/domain/repository/bank_list_repository.dart';
import 'package:wmd/features/add_assets/add_bank_auto/domain/usecase/get_bank_list.dart';
import 'package:wmd/features/add_assets/add_bank_auto/domain/usecase/get_popular_bank_list.dart';

import 'get_bank_list_usecase_test.mocks.dart';

@GenerateMocks([BankListRepository])
void main() {
  late MockBankListRepository mockBankListRepository;
  late GetBankListsUseCase getBankListsUseCase;
  late GetPopularBankListUseCase getPopularBankListUseCase;
  setUp(() {
    mockBankListRepository = MockBankListRepository();
    getBankListsUseCase = GetBankListsUseCase(mockBankListRepository);
    getPopularBankListUseCase =
        GetPopularBankListUseCase(mockBankListRepository);
  });
  const int count = 1;
  final tBankResponse = BankResponse.fromJson(BankResponse.tBankResponse);
  final tList = List<BankResponse>.generate(count, (index) => tBankResponse);
  final tEither = Right<Failure, List<BankResponse>>(tList);
  group('BankList usecase test', () {
    test(
      'should get BankEntity from bankListRepository',
      () async {
        // arrange
        when(mockBankListRepository.getBankList(NoParams()))
            .thenAnswer((_) async => tEither);
        // act
        final result = await getBankListsUseCase.call('Red');
        // assert
        expect(result.fold((l) => l, (r) => r), tList);
      },
    );

    test(
      'should get ServerFailure from the bank repository when server request fails',
      () async {
        const tServerFailure = ServerFailure(message: 'Server failure');
        // arrange
        when(mockBankListRepository.getBankList(NoParams()))
            .thenAnswer((_) async => const Left(tServerFailure));
        // act
        final result = await getBankListsUseCase('Red');
        // assert
        expect(result, const Left(tServerFailure));
      },
    );
  });
  group('PopularBankList usecase test', () {
    test(
      'should get BankEntity from bankListRepository',
      () async {
        // arrange
        when(mockBankListRepository.getPopularBankList(null))
            .thenAnswer((_) async => tEither);
        // act
        final result = await getPopularBankListUseCase.call(NoParams());
        // assert
        expect(result.fold((l) => l, (r) => r), tList);
      },
    );

    test(
      'should get ServerFailure from the bank repository when server request fails',
      () async {
        const tServerFailure = ServerFailure(message: 'Server failure');
        // arrange
        when(mockBankListRepository.getPopularBankList(null))
            .thenAnswer((_) async => const Left(tServerFailure));
        // act
        final result = await getPopularBankListUseCase.call(NoParams());
        // assert
        expect(result, const Left(tServerFailure));
      },
    );
  });
}
