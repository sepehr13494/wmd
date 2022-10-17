import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/data/repositories/dashboard_respository_impl.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/dashboard_repository.dart';

import '../../domain/use_cases/get_user_status_usecase_test.mocks.dart';
import 'dashboard_repository_impl_test.mocks.dart';

@GenerateMocks([DashboardRemoteDataSource])
void main() {
  late MockDashboardRepository mockDashboardRepository;
  late MockDashboardRemoteDataSource mockDashboardRemoteDataSource;
  late DashboardRepositoryImpl dashboardRepositoryImpl;

  setUp(() async {
    mockDashboardRemoteDataSource = MockDashboardRemoteDataSource();
    mockDashboardRepository = MockDashboardRepository();
    dashboardRepositoryImpl =
        DashboardRepositoryImpl(mockDashboardRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for getUserStatus in Dashboard Repository', () {
    test(
      'should return remote data when the call to auth remote data source is successful',
      () async {
        // arrange
        when(mockDashboardRemoteDataSource.getUserStatus(any))
            .thenAnswer((_) async => UserStatus.tUserStatusParam);
        // act
        final result = await dashboardRepositoryImpl.getUserStatus(NoParams());
        // assert
        verify(dashboardRepositoryImpl.getUserStatus(NoParams()));
        expect(result, equals(Right(UserStatus.tUserStatusParam)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockDashboardRemoteDataSource.getUserStatus(any))
            .thenThrow(tServerException);
        // act
        final result = await dashboardRepositoryImpl.getUserStatus(NoParams());
        // assert
        verify(mockDashboardRemoteDataSource.getUserStatus(NoParams()));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
