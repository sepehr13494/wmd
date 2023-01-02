import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/use_cases/user_net_worth_usecase.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

import 'main_dashboard_cubit_test.mocks.dart';

@GenerateMocks([UserNetWorthUseCase])
void main() {
  late MockUserNetWorthUseCase mockUserNetWorthUseCase;
  late MainDashboardCubit mainDashboardCubit;

  final tDateTimeRange = DateTimeRange(
      start: NetWorthParams.tNetWorthParams.from!,
      end: NetWorthParams.tNetWorthParams.to!);

  setUp(() {
    mockUserNetWorthUseCase = MockUserNetWorthUseCase();
    mainDashboardCubit = MainDashboardCubit(mockUserNetWorthUseCase);
  });

  blocTest(
    'when getNetWorth is success emits the MainDashboardLoaded when success',
    build: () => mainDashboardCubit,
    setUp: () => when(mockUserNetWorthUseCase(any)).thenAnswer(
        (realInvocation) async =>
            const Right(NetWorthResponseObj.tNetWorthResponseObj)),
    act: (bloc) async => await bloc.getNetWorth(),
    expect: () => [
      isA<LoadingState>(),
      MainDashboardNetWorthLoaded(
          netWorthObj: NetWorthResponseObj.tNetWorthResponseObj)
    ],
    verify: (_) {
      verify(mockUserNetWorthUseCase(tDateTimeRange));
    },
  );

  blocTest(
    'when getNetWorth is not success emits the ErrorState when error',
    build: () => mainDashboardCubit,
    setUp: () => when(mockUserNetWorthUseCase(any)).thenAnswer(
        (realInvocation) async => const Left(ServerFailure.tServerFailure)),
    act: (bloc) async => await bloc.getNetWorth(),
    expect: () => [
      isA<LoadingState>(),
      ErrorState(failure: ServerFailure.tServerFailure)
    ],
    verify: (_) {
      verify(mockUserNetWorthUseCase(tDateTimeRange));
    },
  );
}
