import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import '../../data/repositories/loan_liability_repository_impl_test.mocks.dart';

void main() {
  late MockLoanLiabilityRepository mockLoanLiabilityRepository;
  late AddLoanLiabilityUseCase addLoanLiabilityUseCase;

  setUp(() {
    mockLoanLiabilityRepository = MockLoanLiabilityRepository();
    addLoanLiabilityUseCase =
        AddLoanLiabilityUseCase(mockLoanLiabilityRepository);
  });

  final tAddResponse = AddAssetModel.fromJson(AddAssetModel.tAddAssetResponse);

  test(
    'should get AddAssetModal from loan liability repository',
    () async {
      // arrange
      when(mockLoanLiabilityRepository.postLoanLiability(
              AddLoanLiabilityParams.tAddLoanLiabilityParams))
          .thenAnswer((_) async => Right(tAddResponse));

      // act
      final result = await addLoanLiabilityUseCase(
          AddLoanLiabilityParams.tAddLoanLiabilityMap);
      // assert
      expect(result, Right(tAddResponse));
    },
  );

  test(
    'should get ServerFailure from the loan liability repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockLoanLiabilityRepository.postLoanLiability(
              AddLoanLiabilityParams.tAddLoanLiabilityParams))
          .thenAnswer((_) async => const Left(tServerFailure));

      // act
      final result = await addLoanLiabilityUseCase(
          AddLoanLiabilityParams.tAddLoanLiabilityMap);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
