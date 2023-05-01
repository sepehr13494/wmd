import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/put_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/put_private_equity_usecase.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import '../../data/repositories/edit_private_equity_repository_impl_test.mocks.dart';




void main() {
  late PutPrivateEquityUseCase putPrivateEquityUseCase;
  late MockEditPrivateEquityRepository mockEditPrivateEquityRepository;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockEditPrivateEquityRepository = MockEditPrivateEquityRepository();
    mockLocalStorage = MockLocalStorage();
    putPrivateEquityUseCase = PutPrivateEquityUseCase(mockEditPrivateEquityRepository,mockLocalStorage);
  });

  test('should get PutPrivateEquityEntity from the repository', () async {
    //arrange
    when(mockEditPrivateEquityRepository.putPrivateEquity(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "Successfully done")));
    when(mockLocalStorage.getOwnerId())
        .thenAnswer((realInvocation) => "ownerId");
    // act
    final result = await putPrivateEquityUseCase(AddPrivateEquityParams.tAddPrivateEquityMap,PutPrivateEquityParams.tParams.assetId);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditPrivateEquityRepository.putPrivateEquity(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      //act
      final result = await putPrivateEquityUseCase(AddPrivateEquityParams.tAddPrivateEquityMap,PutPrivateEquityParams.tParams.assetId);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditPrivateEquityRepository.putPrivateEquity(PutPrivateEquityParams.tParams));
    },
  );
}

    