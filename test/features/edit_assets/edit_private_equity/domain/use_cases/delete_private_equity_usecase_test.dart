import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/delete_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/delete_private_equity_usecase.dart';

import '../../data/repositories/edit_private_equity_repository_impl_test.mocks.dart';




void main() {
  late DeletePrivateEquityUseCase deletePrivateEquityUseCase;
  late MockEditPrivateEquityRepository mockEditPrivateEquityRepository;

  setUp(() {
    mockEditPrivateEquityRepository = MockEditPrivateEquityRepository();
    deletePrivateEquityUseCase = DeletePrivateEquityUseCase(mockEditPrivateEquityRepository);
  });

  test('should get DeletePrivateEquityEntity from the repository', () async {
    //arrange
    when(mockEditPrivateEquityRepository.deletePrivateEquity(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "successfully done")));
    // act
    final result = await deletePrivateEquityUseCase(DeletePrivateEquityParams.tParams);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditPrivateEquityRepository.deletePrivateEquity(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await deletePrivateEquityUseCase(DeletePrivateEquityParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditPrivateEquityRepository.deletePrivateEquity(DeletePrivateEquityParams.tParams));
    },
  );
}

    