import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_params.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/domain/use_cases/get_manual_list_usecase.dart';


import '../../data/repositories/manual_bank_list_repository_impl_test.mocks.dart';




void main() {
  late GetManualListUseCase getManualListUseCase;
  late MockManualBankListRepository mockManualBankListRepository;

  setUp(() {
    mockManualBankListRepository = MockManualBankListRepository();
    getManualListUseCase = GetManualListUseCase(mockManualBankListRepository);
  });

  test('should get GetManualListEntity from the repository', () async {
    //arrange
    when(mockManualBankListRepository.getManualList(any))
        .thenAnswer((_) async => Right(GetManualListResponse.tResponse));
    // act
    final result = await getManualListUseCase(GetManualListParams.tParams);

    // assert
    expect(result, equals(Right(GetManualListResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockManualBankListRepository.getManualList(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getManualListUseCase(GetManualListParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockManualBankListRepository.getManualList(GetManualListParams.tParams));
    },
  );
}

    