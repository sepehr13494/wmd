import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/use_cases/delete_bank_manual_usecase.dart';

import '../../data/repositories/edit_bank_manual_repository_impl_test.mocks.dart';




void main() {
  late DeleteBankManualUseCase deleteBankManualUseCase;
  late MockEditBankManualRepository mockEditBankManualRepository;

  setUp(() {
    mockEditBankManualRepository = MockEditBankManualRepository();
    deleteBankManualUseCase = DeleteBankManualUseCase(mockEditBankManualRepository);
  });

  test('should get DeleteBankManualEntity from the repository', () async {
    //arrange
    when(mockEditBankManualRepository.deleteBankManual(any))
        .thenAnswer((_) async => const Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await deleteBankManualUseCase(DeleteBankManualParams.tParams);

    // assert
    expect(result, equals(const Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditBankManualRepository.deleteBankManual(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await deleteBankManualUseCase(DeleteBankManualParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditBankManualRepository.deleteBankManual(DeleteBankManualParams.tParams));
    },
  );
}

    