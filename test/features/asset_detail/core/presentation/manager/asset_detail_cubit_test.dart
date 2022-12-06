import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';
import 'package:wmd/features/asset_detail/core/domain/entities/get_detail_entity.dart';
import 'package:wmd/features/asset_detail/core/domain/use_cases/get_detail_usecase.dart';
import 'package:wmd/features/asset_detail/core/presentation/manager/asset_detail_cubit.dart';

import 'asset_detail_cubit_test.mocks.dart';

@GenerateMocks([GetDetailUseCase])
void main() {
  late MockGetDetailUseCase mockGetDetailUseCase;
  late AssetDetailCubit assetDetailCubit;

  setUp(() {
    mockGetDetailUseCase = MockGetDetailUseCase();
    assetDetailCubit = AssetDetailCubit(mockGetDetailUseCase);
  });

  // const int count = 1;
  final tResponse =
      BankAccountResponse.fromJson(BankAccountResponse.tBankAccountResponse);
  final tEither = Right<Failure, GetDetailEntity>((tResponse));
  GetDetailParams params =
      const GetDetailParams(type: 'BankAccount', assetId: 'assetId');

  blocTest(
    'when bankListCubit is emit the bankList when success',
    build: () => assetDetailCubit,
    setUp: () => when(mockGetDetailUseCase(any))
        .thenAnswer((realInvocation) async => tEither),
    act: (bloc) async => await bloc.getDetail(params),
    expect: () => [
      isA<LoadingState>(),
      isA<AssetLoaded>(),
    ],
    verify: (_) {
      verify(mockGetDetailUseCase(params)).called(1);
    },
  );
}
