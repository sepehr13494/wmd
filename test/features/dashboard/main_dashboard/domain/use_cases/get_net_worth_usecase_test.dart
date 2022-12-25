import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/use_cases/user_net_worth_usecase.dart';

import '../../data/repositories/main_dashboard_repository_impl_test.mocks.dart';



void main() {
  late UserNetWorthUseCase userNetWorthUseCase;
  late MockMainDashboardRepository mockMainDashboardRepository;
  const tDateTimeRange = MapEntry("7 days", 7);

  setUp(() {
    mockMainDashboardRepository = MockMainDashboardRepository();
    userNetWorthUseCase = UserNetWorthUseCase(mockMainDashboardRepository);
  });

  test('should get user net worth from the main dashboard repository', () async {
    //arrange
    when(mockMainDashboardRepository.userNetWorth(any))
        .thenAnswer((_) async => const Right(NetWorthResponseObj.tNetWorthResponseObj));
    // act
    final result = await userNetWorthUseCase(tDateTimeRange);

    // assert
    expect(result, equals(const Right(NetWorthResponseObj.tNetWorthResponseObj)));
  });

  test(
    'should get Server Failure from the main dashboard repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      //arrange
      when(mockMainDashboardRepository.userNetWorth(any))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await userNetWorthUseCase(tDateTimeRange);
      //assert
      expect(result, const Left(tServerFailure));
      verify(mockMainDashboardRepository.userNetWorth(NetWorthParams.tNetWorthParams));
    },
  );
}
