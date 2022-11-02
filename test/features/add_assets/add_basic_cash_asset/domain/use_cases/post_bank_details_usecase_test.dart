import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_fail_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/repositories/bank_repository.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

import 'post_bank_details_usecase_test.mocks.dart';

@GenerateMocks([BankRepository])
void main() {
  late MockBankRepository mockBankRepository;
  late PostBankDetailsUseCase postBankDetailsUseCase;
  setUp(() {
    mockBankRepository = MockBankRepository();
    postBankDetailsUseCase = PostBankDetailsUseCase(mockBankRepository);
  });

  final tBankSaveResponse =
      BankSaveResponseModel.fromJson(BankSaveResponseModel.tBankSaveResponse);

  test(
    'should get BankSaveResponse from bank repository',
    () async {
      // arrange
      when(mockBankRepository.postBankDetails(BankSaveParams.tBankSaveParams))
          .thenAnswer((_) async => Right(tBankSaveResponse));
      // act
      final result =
          await postBankDetailsUseCase.call(BankSaveParams.tBankSaveParams);
      // assert
      expect(result, Right(tBankSaveResponse));
    },
  );

  test(
    'should get ServerFailure from the bank repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockBankRepository.postBankDetails(BankSaveParams.tBankSaveParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result =
          await postBankDetailsUseCase.call(BankSaveParams.tBankSaveParams);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
