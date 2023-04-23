import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/delete_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/use_cases/delete_private_debt_usecase.dart';

import '../../data/repositories/edit_private_debt_repository_impl_test.mocks.dart';




void main() {
  late DeletePrivateDebtUseCase deletePrivateDebtUseCase;
  late MockEditPrivateDebtRepository mockEditPrivateDebtRepository;

  setUp(() {
    mockEditPrivateDebtRepository = MockEditPrivateDebtRepository();
    deletePrivateDebtUseCase = DeletePrivateDebtUseCase(mockEditPrivateDebtRepository);
  });

  test('should get DeletePrivateDebtEntity from the repository', () async {
    //arrange
    when(mockEditPrivateDebtRepository.deletePrivateDebt(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "successfully done")));
    // act
    final result = await deletePrivateDebtUseCase(DeletePrivateDebtParams.tParams);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditPrivateDebtRepository.deletePrivateDebt(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await deletePrivateDebtUseCase(DeletePrivateDebtParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditPrivateDebtRepository.deletePrivateDebt(DeletePrivateDebtParams.tParams));
    },
  );
}

    