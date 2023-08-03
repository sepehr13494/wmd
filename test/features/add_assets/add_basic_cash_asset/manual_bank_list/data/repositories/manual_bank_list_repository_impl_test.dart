import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/data_sources/manual_bank_list_remote_datasource.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_params.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/repositories/manual_bank_list_repository_impl.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/domain/repositories/manual_bank_list_repository.dart';

import 'manual_bank_list_repository_impl_test.mocks.dart';


@GenerateMocks([ManualBankListRemoteDataSource,ManualBankListRepository])
void main() {
  late MockManualBankListRemoteDataSource remoteDataSource;
  late ManualBankListRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockManualBankListRemoteDataSource();
    repositoryImpl = ManualBankListRepositoryImpl(
        remoteDataSource);
  });

  group('GetManualList', () {
    test(
      'should return GetManualListResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getManualList(any))
            .thenAnswer((_) async => GetManualListResponse.tResponse);
        // act
        final result = await repositoryImpl.getManualList(GetManualListParams.tParams);
        // assert
        expect(result, equals(Right(GetManualListResponse.tResponse)));
        verify(remoteDataSource.getManualList(GetManualListParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getManualList(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getManualList(GetManualListParams.tParams);
        // assert
        verify(remoteDataSource.getManualList(GetManualListParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getManualList(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getManualList(GetManualListParams.tParams);
        // assert
        verify(remoteDataSource.getManualList(GetManualListParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
