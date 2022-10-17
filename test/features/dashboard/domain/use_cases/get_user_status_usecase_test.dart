import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/dashboard/data/models/user_status.dart';
import 'package:wmd/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:wmd/features/dashboard/domain/use_cases/get_user_status_usecase.dart';

import 'get_user_status_usecase_test.mocks.dart';

@GenerateMocks([DashboardRepository])
void main() {
  late GetUserStatusUseCase getUserStatusUseCase;
  late MockDashboardRepository mockDashboardRepository;

  setUp(() {
    mockDashboardRepository = MockDashboardRepository();
    getUserStatusUseCase = GetUserStatusUseCase(mockDashboardRepository);
    CustomizableDateTime.customTime = DateTime.now();
  });
  final tNoParams = NoParams();
  final tUserStatus = UserStatus(
      email: "test@yopmail.com",
      loginAt: CustomizableDateTime.current.toString());

  test('should get UserStatus from the dashboard repository', () async {
    //arrange
    when(mockDashboardRepository.getUserStatus(tNoParams))
        .thenAnswer((_) async => Right(tUserStatus));
    // act
    final result = await getUserStatusUseCase.call(tNoParams);

    // assert
    expect(result, equals(Right(tUserStatus)));
  });

  test(
    'should get Server Failure from the dashboard repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      //arrange
      when(mockDashboardRepository.getUserStatus(tNoParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await getUserStatusUseCase.call(tNoParams);
      //assert
      expect(result, const Left(tServerFailure));
    },
  );
}
