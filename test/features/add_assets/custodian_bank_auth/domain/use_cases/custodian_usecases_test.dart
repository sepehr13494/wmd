import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/custodian_bank_response.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_list_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_response.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/post_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/post_custodian_bank_status_response.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/post_custodian_bank_status_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/repositories/custodian_bank_auth_repository.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/get_custodian_bank_list_usecase.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/get_custodian_bank_status_usecase.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/post_custodian_bank_status_usecase.dart';

import 'custodian_usecases_test.mocks.dart';

@GenerateMocks([CustodianBankAuthRepository])
void main() {
  late MockCustodianBankAuthRepository mockCustodianBankAuthRepository;
  late GetCustodianBankListUseCase getCustodianBankListUseCase;
  late GetCustodianBankStatusUseCase getCustodianBankStatusUseCase;
  late PostCustodianBankStatusUseCase postCustodianBankStatusUseCase;
  setUp(() {
    mockCustodianBankAuthRepository = MockCustodianBankAuthRepository();
    getCustodianBankListUseCase =
        GetCustodianBankListUseCase(mockCustodianBankAuthRepository);
    getCustodianBankStatusUseCase =
        GetCustodianBankStatusUseCase(mockCustodianBankAuthRepository);
    postCustodianBankStatusUseCase =
        PostCustodianBankStatusUseCase(mockCustodianBankAuthRepository);
  });

  group('getCustodianBankStatusUseCase usecase test', () {
    final resp = GetCustodianBankStatusResponse.fromJson(
        CustodianBankStatusEntity.tResponse);
    final tEither = Right<Failure, CustodianBankStatusEntity>(resp);
    test(
      'should get bank status from repository',
      () async {
        // arrange
        when(mockCustodianBankAuthRepository.getCustodianBankStatus(
                GetCustodianBankStatusParams(
                    bankId: resp.bankId, custodianBankStatusId: null)))
            .thenAnswer((_) async => tEither);
        // act
        final result = await getCustodianBankStatusUseCase.call(
            GetCustodianBankStatusParams(
                bankId: resp.bankId, custodianBankStatusId: null));
        // assert
        expect(result.fold((l) => l, (r) => r), resp);
      },
    );

    test(
      'should get ServerFailure from the repository when server request fails',
      () async {
        const tServerFailure = ServerFailure(message: 'Server failure');
        // arrange
        when(mockCustodianBankAuthRepository.getCustodianBankStatus(
                GetCustodianBankStatusParams(
                    bankId: resp.bankId, custodianBankStatusId: resp.bankId)))
            .thenAnswer((_) async => const Left(tServerFailure));
        // act
        final result = await getCustodianBankStatusUseCase.call(
            GetCustodianBankStatusParams(
                bankId: resp.bankId, custodianBankStatusId: resp.bankId));
        // assert
        expect(result, const Left(tServerFailure));
      },
    );
  });

  group('getCustodianBankList usecase test', () {
    final tList = List.generate(
        3,
        (index) =>
            CustodianBankResponse.fromJson(CustodianBankResponse.tResponse));
    final tEither = Right<Failure, List<CustodianBankResponse>>(tList);
    test(
      'should get banklist from repository',
      () async {
        // arrange
        when(mockCustodianBankAuthRepository
                .getCustodianBankList(GetCustodianBankListParams()))
            .thenAnswer((_) async => tEither);
        // act
        final result = await getCustodianBankListUseCase
            .call(GetCustodianBankListParams());
        // assert
        expect(result.fold((l) => l, (r) => r), tList);
      },
    );

    test(
      'should get ServerFailure from the bank repository when server request fails',
      () async {
        const tServerFailure = ServerFailure(message: 'Server failure');
        // arrange
        when(mockCustodianBankAuthRepository
                .getCustodianBankList(GetCustodianBankListParams()))
            .thenAnswer((_) async => const Left(tServerFailure));
        // act
        final result = await getCustodianBankListUseCase
            .call(GetCustodianBankListParams());
        // assert
        expect(result, const Left(tServerFailure));
      },
    );
  });
  /////////////////////////////////??&&&&5^&$%&4////////
  group('postCustodianBankStatusUseCase usecase test', () {
    final tModel = PostCustodianBankStatusParams.fromJson(
        PostCustodianBankStatusParams.tResponse);
    const resp = PostCustodianBankStatusResponse(id: 'test');
    const tEither = Right<Failure, PostCustodianBankStatusEntity>(resp);
    test(
      'should get bool from repository',
      () async {
        // arrange
        when(mockCustodianBankAuthRepository.postCustodianBankStatus(tModel))
            .thenAnswer((_) async => tEither);
        // act
        final result = await postCustodianBankStatusUseCase.call(tModel);
        // assert
        expect(result.fold((l) => l, (r) => r), resp);
      },
    );

    test(
      'should get ServerFailure from the bank repository when server request fails',
      () async {
        const tServerFailure = ServerFailure(message: 'Server failure');
        // arrange
        when(mockCustodianBankAuthRepository.postCustodianBankStatus(tModel))
            .thenAnswer((_) async => const Left(tServerFailure));
        // act
        final result = await postCustodianBankStatusUseCase.call(tModel);
        // assert
        expect(result, const Left(tServerFailure));
      },
    );
  });
}
