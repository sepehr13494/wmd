import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/repositories/private_equity_repository.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import 'add_private_equity_usecase_test.mocks.dart';

@GenerateMocks([PrivateEquityRepository])
void main() {
  late MockPrivateEquityRepository mockPrivateEquityRepository;
  late AddPrivateEquityUseCase addPrivateEquityUseCase;
  late MockLocalStorage mockLocalStorage;
  setUp(() {
    mockPrivateEquityRepository = MockPrivateEquityRepository();
    mockLocalStorage = MockLocalStorage();
    addPrivateEquityUseCase =
        AddPrivateEquityUseCase(mockPrivateEquityRepository, mockLocalStorage);
  });

  final tAddPrivateEquityResponse =
      AddAssetModel.fromJson(AddAssetModel.tAddAssetResponse);

  test(
    'should get AddAssetModal from private equity repository',
    () async {
      // arrange
      when(mockPrivateEquityRepository.postPrivateEquity(
              AddPrivateEquityParams.tAddPrivateEquityParams))
          .thenAnswer((_) async => Right(tAddPrivateEquityResponse));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      // act
      final result = await addPrivateEquityUseCase(
          AddPrivateEquityParams.tAddPrivateEquityMap);
      // assert
      expect(result, Right(tAddPrivateEquityResponse));
    },
  );

  test(
    'should get ServerFailure from the private equity repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockPrivateEquityRepository.postPrivateEquity(
              AddPrivateEquityParams.tAddPrivateEquityParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      // act
      final result = await addPrivateEquityUseCase(
          AddPrivateEquityParams.tAddPrivateEquityMap);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
