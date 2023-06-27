    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_params.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/domain/use_cases/get_manual_list_usecase.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/presentation/manager/manual_bank_list_cubit.dart';

import 'manual_bank_list_cubit_test.mocks.dart';



@GenerateMocks([
  GetManualListUseCase,

])
void main() {
  late MockGetManualListUseCase mockGetManualListUseCase;

  late ManualBankListCubit manualBankListCubit;


  setUp(() {
    mockGetManualListUseCase = MockGetManualListUseCase();

    manualBankListCubit = ManualBankListCubit(
    mockGetManualListUseCase,

    );
  });
  

  group("getManualList", () {
    blocTest(
      'when GetManualListUseCase emits the GetManualListLoaded when success',
      build: () => manualBankListCubit,
      setUp: () => when(mockGetManualListUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetManualListResponse.tResponse)),
      act: (bloc) async => await bloc.getManualList(text: "test"),
      expect: () =>
      [isA<LoadingState>(), GetManualListLoaded(getManualListEntities : GetManualListResponse.tResponse)],
      verify: (_) {
        verify(mockGetManualListUseCase(GetManualListParams.tParams));
      },
    );

    blocTest(
      'when GetManualListUseCase emits the ErrorState when error',
      build: () => manualBankListCubit,
      setUp: () => when(mockGetManualListUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getManualList(text: "test"),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetManualListUseCase(GetManualListParams.tParams));
      },
    );
  });

}

    