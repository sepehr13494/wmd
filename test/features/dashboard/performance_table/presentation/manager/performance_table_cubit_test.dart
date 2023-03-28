    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/models/time_filer_obj.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_response.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_response.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_response.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_asset_class_usecase.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_benchmark_usecase.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_custodian_performance_usecase.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';

import 'performance_table_cubit_test.mocks.dart';



@GenerateMocks([
  GetAssetClassUseCase,
  GetBenchmarkUseCase,
  GetCustodianPerformanceUseCase,

])
void main() {
  late MockGetAssetClassUseCase mockGetAssetClassUseCase;
  late MockGetBenchmarkUseCase mockGetBenchmarkUseCase;
  late MockGetCustodianPerformanceUseCase mockGetCustodianPerformanceUseCase;

  late PerformanceTableCubit performanceTableCubit;


  setUp(() {
    mockGetAssetClassUseCase = MockGetAssetClassUseCase();
    mockGetBenchmarkUseCase = MockGetBenchmarkUseCase();
    mockGetCustodianPerformanceUseCase = MockGetCustodianPerformanceUseCase();

    performanceTableCubit = PerformanceTableCubit(
    mockGetAssetClassUseCase,
    mockGetBenchmarkUseCase,
    mockGetCustodianPerformanceUseCase,

    );
  });
  

  group("getAssetClass", () {
    blocTest(
      'when GetAssetClassUseCase emits the GetAssetClassLoaded when success',
      build: () => performanceTableCubit,
      setUp: () => when(mockGetAssetClassUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetAssetClassResponse.tResponse)),
      act: (bloc) async => await bloc.getAssetClass(period: TimeFilterObj.tTimeFilterObj),
      expect: () =>
      [isA<LoadingState>(), GetAssetClassLoaded(getAssetClassEntities : GetAssetClassResponse.tResponse)],
      verify: (_) {
        verify(mockGetAssetClassUseCase(GetAssetClassParams.tParams));
      },
    );

    blocTest(
      'when GetAssetClassUseCase emits the ErrorState when error',
      build: () => performanceTableCubit,
      setUp: () => when(mockGetAssetClassUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getAssetClass(period: TimeFilterObj.tTimeFilterObj),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetAssetClassUseCase(GetAssetClassParams.tParams));
      },
    );
  });
  group("getBenchmark", () {
    blocTest(
      'when GetBenchmarkUseCase emits the GetBenchmarkLoaded when success',
      build: () => performanceTableCubit,
      setUp: () => when(mockGetBenchmarkUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetBenchmarkResponse.tResponse)),
      act: (bloc) async => await bloc.getBenchmark(),
      expect: () =>
      [isA<LoadingState>(), GetBenchmarkLoaded(getBenchmarkEntities : GetBenchmarkResponse.tResponse)],
      verify: (_) {
        verify(mockGetBenchmarkUseCase(GetBenchmarkParams.tParams));
      },
    );

    blocTest(
      'when GetBenchmarkUseCase emits the ErrorState when error',
      build: () => performanceTableCubit,
      setUp: () => when(mockGetBenchmarkUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getBenchmark(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetBenchmarkUseCase(GetBenchmarkParams.tParams));
      },
    );
  });
  group("getCustodianPerformance", () {
    blocTest(
      'when GetCustodianPerformanceUseCase emits the GetCustodianPerformanceLoaded when success',
      build: () => performanceTableCubit,
      setUp: () => when(mockGetCustodianPerformanceUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetCustodianPerformanceResponse.tResponse)),
      act: (bloc) async => await bloc.getCustodianPerformance(),
      expect: () =>
      [isA<LoadingState>(), GetCustodianPerformanceLoaded(getCustodianPerformanceEntities : GetCustodianPerformanceResponse.tResponse)],
      verify: (_) {
        verify(mockGetCustodianPerformanceUseCase(GetCustodianPerformanceParams.tParams));
      },
    );

    blocTest(
      'when GetCustodianPerformanceUseCase emits the ErrorState when error',
      build: () => performanceTableCubit,
      setUp: () => when(mockGetCustodianPerformanceUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getCustodianPerformance(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetCustodianPerformanceUseCase(GetCustodianPerformanceParams.tParams));
      },
    );
  });

}

    