import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_loan_liability/data/data_sources/loan_liability_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_loan_liability/data/repositories/loan_liability_repository_impl.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/repositories/loan_liability_repository.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/add_real_estate/data/data_sources/real_estate_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_real_estate/data/repositories/real_estate_repository_impl.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/repositories/real_estate_repository.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'loan_liability_repository_impl_test.mocks.dart';

@GenerateMocks([LoanLiabilityRemoteDataSource, LoanLiabilityRepository])
void main() {
  late MockLoanLiabilityRemoteDataSource mockLoanLiabilityRemoteDataSource;
  late LoanLiabilityRepositoryImpl loanLiabilityRepositoryImpl;
  setUp(() {
    mockLoanLiabilityRemoteDataSource = MockLoanLiabilityRemoteDataSource();
    loanLiabilityRepositoryImpl =
        LoanLiabilityRepositoryImpl(mockLoanLiabilityRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for postLoanLiability in Loan Liability Repository', () {
    test(
      'should return save response data when the call to real estate remote data source is successful',
      () async {
        // arrange
        when(mockLoanLiabilityRemoteDataSource.postLoanLiability(any))
            .thenAnswer((_) async => AddAssetModel.tAddAssetModel);
        // act
        final result = await loanLiabilityRepositoryImpl
            .postLoanLiability(AddLoanLiabilityParams.tAddLoanLiabilityParams);
        // assert
        verify(mockLoanLiabilityRemoteDataSource
            .postLoanLiability(AddLoanLiabilityParams.tAddLoanLiabilityParams));
        expect(result, equals(const Right(AddAssetModel.tAddAssetModel)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockLoanLiabilityRemoteDataSource.postLoanLiability(any))
            .thenThrow(tServerException);
        // act
        final result = await loanLiabilityRepositoryImpl
            .postLoanLiability(AddLoanLiabilityParams.tAddLoanLiabilityParams);
        // assert
        verify(mockLoanLiabilityRemoteDataSource
            .postLoanLiability(AddLoanLiabilityParams.tAddLoanLiabilityParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
