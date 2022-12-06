import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';
import 'package:wmd/features/asset_detail/core/domain/entities/get_detail_entity.dart';
import 'package:wmd/features/asset_detail/core/domain/use_cases/get_detail_usecase.dart';
import '../../data/repositories/asset_detail_repository_impl_test.mocks.dart';

void main() {
  late MockAssetDetailRepository mockAssetDetailRepository;
  late GetDetailUseCase getDetailUseCase;
  late GetDetailEntity tSuccess;

  setUp(() {
    tSuccess =
        BankAccountResponse.fromJson(BankAccountResponse.tBankAccountResponse);
    mockAssetDetailRepository = MockAssetDetailRepository();
    getDetailUseCase = GetDetailUseCase(mockAssetDetailRepository);
  });

  const GetDetailParams params =
      GetDetailParams(type: 'BankAccount', assetId: 'assetId');

  test(
    'should get getDetail entity from repository',
    () async {
      //arrange
      when(mockAssetDetailRepository.getDetail(params))
          .thenAnswer((_) async => Right(tSuccess));
      //act
      final result = await getDetailUseCase.call(params);
      //assert
      expect(result, equals(Right(tSuccess)));
    },
  );

  test(
    'should get Server Failure from repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      //arrange
      when(mockAssetDetailRepository.getDetail(params))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await getDetailUseCase.call(params);
      //assert
      expect(result, const Left(tServerFailure));
    },
  );
}
