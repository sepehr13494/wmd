import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/repositories/bank_repository.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import 'post_bank_details_usecase_test.mocks.dart';

@GenerateMocks([BankRepository])
void main() {
  late MockBankRepository mockBankRepository;
  late PostBankDetailsUseCase postBankDetailsUseCase;
  late MockLocalStorage mockLocalStorage;
  setUp(() {
    mockBankRepository = MockBankRepository();
    mockLocalStorage = MockLocalStorage();
    postBankDetailsUseCase =
        PostBankDetailsUseCase(mockBankRepository, mockLocalStorage);
  });

  final tAddResponse = AddAssetModel.fromJson(AddAssetModel.tAddAssetResponse);

  test(
    'should get BankSaveResponse from bank repository',
    () async {
      // arrange
      when(mockBankRepository.postBankDetails(BankSaveParams.tBankSaveParams))
          .thenAnswer((_) async => Right(tAddResponse));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      // act
      final result = await postBankDetailsUseCase(BankSaveParams.tBankFormMap);
      // assert
      expect(result, Right(tAddResponse));
    },
  );

  test(
    'should get ServerFailure from the bank repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockBankRepository.postBankDetails(BankSaveParams.tBankSaveParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      // act
      final result = await postBankDetailsUseCase(BankSaveParams.tBankFormMap);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
