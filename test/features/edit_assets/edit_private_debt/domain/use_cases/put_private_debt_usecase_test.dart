import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/put_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/use_cases/put_private_debt_usecase.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import '../../data/repositories/edit_private_debt_repository_impl_test.mocks.dart';




void main() {
  late PutPrivateDebtUseCase putPrivateDebtUseCase;
  late MockEditPrivateDebtRepository mockEditPrivateDebtRepository;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockEditPrivateDebtRepository = MockEditPrivateDebtRepository();
    mockLocalStorage = MockLocalStorage();
    putPrivateDebtUseCase = PutPrivateDebtUseCase(mockEditPrivateDebtRepository,mockLocalStorage);
  });

  test('should get PutPrivateDebtEntity from the repository', () async {
    //arrange
    when(mockEditPrivateDebtRepository.putPrivateDebt(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await putPrivateDebtUseCase(PutPrivateDebtParams.tParams.addPrivateDebtParams.toJson(),PutPrivateDebtParams.tParams.assetId);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditPrivateDebtRepository.putPrivateDebt(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await putPrivateDebtUseCase(PutPrivateDebtParams.tParams.addPrivateDebtParams.toJson(),PutPrivateDebtParams.tParams.assetId);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditPrivateDebtRepository.putPrivateDebt(PutPrivateDebtParams.tParams));
    },
  );
}

    