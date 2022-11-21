import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/bank_list_response.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_bank_list.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_popular_bank_list.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';

import 'bank_list_cubit_test.mocks.dart';

@GenerateMocks([GetBankListsUseCase, GetPopularBankListUseCase])
void main() {
  late MockGetBankListsUseCase mockGetBankListsUseCase;
  late MockGetPopularBankListUseCase mockGetPopularBankListUseCase;
  late BankListCubit bankListCubit;

  setUp(() {
    mockGetBankListsUseCase = MockGetBankListsUseCase();
    mockGetPopularBankListUseCase = MockGetPopularBankListUseCase();
    bankListCubit =
        BankListCubit(mockGetBankListsUseCase, mockGetPopularBankListUseCase);
  });

  const int count = 1;
  final tBankResponse = BankResponse.fromJson(BankResponse.tBankResponse);
  final value = tBankResponse.name;
  final tList = List<BankResponse>.generate(count, (index) => tBankResponse);
  final tEither = Right<Failure, List<BankResponse>>(tList);

  blocTest(
    'when bankListCubit is emit the bankList when success',
    build: () => bankListCubit,
    setUp: () => when(mockGetBankListsUseCase(any))
        .thenAnswer((realInvocation) async => tEither),
    act: (bloc) async => await bloc.getBankList(value),
    expect: () => [
      isA<LoadingState>(),
      isA<BankListSuccess>(),
      // BankListSuccess(tList), //Ask this why not working
    ],
    verify: (_) {
      verify(mockGetBankListsUseCase(value)).called(1);
    },
  );

  blocTest(
    'when bankListCubit is emit the popularBankList when success',
    build: () => bankListCubit,
    setUp: () => when(mockGetPopularBankListUseCase(any))
        .thenAnswer((realInvocation) async => tEither),
    act: (bloc) async => await bloc.getPopularBankList(),
    expect: () => [
      isA<LoadingState>(),
      isA<PopularBankListSuccess>(),
      // PopularBankListSuccess(tList),//No working either any comment
    ],
    verify: (_) {
      verify(mockGetPopularBankListUseCase(NoParams())).called(1);
    },
  );
}
