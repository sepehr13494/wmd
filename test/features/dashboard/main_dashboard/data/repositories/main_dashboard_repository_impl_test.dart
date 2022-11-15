import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/data_sources/main_dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/repositories/main_dashboard_respository_impl.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/repositories/main_dashboard_repository.dart';

import 'main_dashboard_repository_impl_test.mocks.dart';


@GenerateMocks([MainDashboardRemoteDataSource,MainDashboardRepository])
void main() {
  late MockMainDashboardRemoteDataSource mainDashboardRemoteDataSource;
  late MainDashboardRepositoryImpl mainDashboardRepositoryImpl;

  setUp(() async {
    mainDashboardRemoteDataSource = MockMainDashboardRemoteDataSource();
    mainDashboardRepositoryImpl = MainDashboardRepositoryImpl(
        mainDashboardRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for UserNetWorth in MainDashboardRepository', () {
    test(
      'should return remote data when the call to auth remote data source is successful',
      () async {
        // arrange
        when(mainDashboardRemoteDataSource.userNetWorth(any))
            .thenAnswer((_) async => NetWorthResponseObj.tNetWorthResponseObj);
        // act
        final result = await mainDashboardRepositoryImpl.userNetWorth(NetWorthParams.tNetWorthParams);
        // assert
        verify(mainDashboardRemoteDataSource.userNetWorth(NetWorthParams.tNetWorthParams));
        expect(result, equals(const Right(NetWorthResponseObj.tNetWorthResponseObj)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mainDashboardRemoteDataSource.userNetWorth(any))
            .thenThrow(tServerException);
        // act
        final result = await mainDashboardRepositoryImpl.userNetWorth(NetWorthParams.tNetWorthParams);
        // assert
        verify(mainDashboardRemoteDataSource.userNetWorth(NetWorthParams.tNetWorthParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(tServerException))));
      },
    );
  });
}
