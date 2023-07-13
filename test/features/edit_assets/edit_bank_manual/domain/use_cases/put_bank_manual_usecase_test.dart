import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/use_cases/put_bank_manual_usecase.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import '../../data/repositories/edit_bank_manual_repository_impl_test.mocks.dart';




void main() {
  late PutBankManualUseCase putBankManualUseCase;
  late MockEditBankManualRepository mockEditBankManualRepository;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockEditBankManualRepository = MockEditBankManualRepository();
    mockLocalStorage = MockLocalStorage();
    putBankManualUseCase = PutBankManualUseCase(mockEditBankManualRepository,mockLocalStorage);
  });

  test('should get PutBankManualEntity from the repository', () async {
    //arrange
    when(mockEditBankManualRepository.putBankManual(any))
        .thenAnswer((_) async => const Right(AppSuccess(message: "Successfully done")));
    when(mockLocalStorage.getOwnerId())
        .thenAnswer((realInvocation) => "ownerId");
    // act
    final result = await putBankManualUseCase(BankSaveParams.tBankFormMap,PutBankManualParams.tParams.assetId);

    // assert
    expect(result, equals(const Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditBankManualRepository.putBankManual(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      //act
      final result = await putBankManualUseCase(BankSaveParams.tBankFormMap,PutBankManualParams.tParams.assetId);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditBankManualRepository.putBankManual(PutBankManualParams.tParams));
    },
  );
}

    