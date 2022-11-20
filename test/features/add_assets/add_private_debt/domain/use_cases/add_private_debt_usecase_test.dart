import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/repositories/private_debt_repository.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import 'add_private_debt_usecase_test.mocks.dart';

@GenerateMocks([PrivateDebtRepository])
void main() {
  late MockPrivateDebtRepository mockPrivateDebtRepository;
  late AddPrivateDebtUseCase addPrivateDebtUseCase;
  late MockLocalStorage mockLocalStorage;
  setUp(() {
    mockPrivateDebtRepository = MockPrivateDebtRepository();
    mockLocalStorage = MockLocalStorage();
    addPrivateDebtUseCase =
        AddPrivateDebtUseCase(mockPrivateDebtRepository, mockLocalStorage);
  });

  final tAddPrivateEquityResponse =
      AddAssetModel.fromJson(AddAssetModel.tAddAssetResponse);

  test(
    'should get AddAssetModal from private debt repository',
    () async {
      // arrange
      when(mockPrivateDebtRepository
              .postPrivateDebt(AddPrivateDebtParams.tAddPrivateDebtParams))
          .thenAnswer((_) async => Right(tAddPrivateEquityResponse));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      // act
      final result =
          await addPrivateDebtUseCase(AddPrivateDebtParams.tAddPrivateDebtMap);
      // assert
      expect(result, Right(tAddPrivateEquityResponse));
    },
  );

  test(
    'should get ServerFailure from the private debt repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockPrivateDebtRepository
              .postPrivateDebt(AddPrivateDebtParams.tAddPrivateDebtParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      // act
      final result =
          await addPrivateDebtUseCase(AddPrivateDebtParams.tAddPrivateDebtMap);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
