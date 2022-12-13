import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_pie_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_pie_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_allocation_usecase.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_geographic_usecase.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_pie_usecase.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';

import 'dashboard_charts_cubit_test.mocks.dart';



@GenerateMocks([
  GetAllocationUseCase,
  GetGeographicUseCase,
  GetPieUseCase,

])
void main() {
  late MockGetAllocationUseCase mockGetAllocationUseCase;
  late MockGetGeographicUseCase mockGetGeographicUseCase;
  late MockGetPieUseCase mockGetPieUseCase;

  late DashboardChartsCubit dashboardChartsCubit;


  setUp(() {
    mockGetAllocationUseCase = MockGetAllocationUseCase();
    mockGetGeographicUseCase = MockGetGeographicUseCase();
    mockGetPieUseCase = MockGetPieUseCase();

    dashboardChartsCubit = DashboardChartsCubit(
    mockGetAllocationUseCase,
    mockGetGeographicUseCase,
    mockGetPieUseCase,

    );
  });
  

  group("getAllocation", () {
    blocTest(
      'when GetAllocationUseCase emits the GetAllocationLoaded when success',
      build: () => dashboardChartsCubit,
      setUp: () => when(mockGetAllocationUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetAllocationResponse.tResponse)),
      act: (bloc) async => await bloc.getAllocation(),
      expect: () =>
      [isA<LoadingState>(), GetAllocationLoaded(getAllocationEntity: GetAllocationResponse.tResponse)],
      verify: (_) {
        verify(mockGetAllocationUseCase(null));
      },
    );

    blocTest(
      'when GetAllocationUseCase emits the ErrorState when error',
      build: () => dashboardChartsCubit,
      setUp: () => when(mockGetAllocationUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getAllocation(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetAllocationUseCase(null));
      },
    );
  });
  group("getGeographic", () {
    blocTest(
      'when GetGeographicUseCase emits the GetGeographicLoaded when success',
      build: () => dashboardChartsCubit,
      setUp: () => when(mockGetGeographicUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetGeographicResponse.tResponse)),
      act: (bloc) async => await bloc.getGeographic(),
      expect: () =>
      [isA<LoadingState>(), GetGeographicLoaded(getGeographicEntity: GetGeographicResponse.tResponse)],
      verify: (_) {
        verify(mockGetGeographicUseCase(NoParams()));
      },
    );

    blocTest(
      'when GetGeographicUseCase emits the ErrorState when error',
      build: () => dashboardChartsCubit,
      setUp: () => when(mockGetGeographicUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getGeographic(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetGeographicUseCase(NoParams()));
      },
    );
  });
  group("getPie", () {
    blocTest(
      'when GetPieUseCase emits the GetPieLoaded when success',
      build: () => dashboardChartsCubit,
      setUp: () => when(mockGetPieUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetPieResponse.tResponse)),
      act: (bloc) async => await bloc.getPie(),
      expect: () =>
      [isA<LoadingState>(), GetPieLoaded(getPieEntity: GetPieResponse.tResponse)],
      verify: (_) {
        verify(mockGetPieUseCase(NoParams()));
      },
    );

    blocTest(
      'when GetPieUseCase emits the ErrorState when error',
      build: () => dashboardChartsCubit,
      setUp: () => when(mockGetPieUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getPie(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetPieUseCase(NoParams()));
      },
    );
  });

}

    