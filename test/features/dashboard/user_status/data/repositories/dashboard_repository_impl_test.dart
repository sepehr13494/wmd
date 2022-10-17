import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/data/repositories/user_status_respository_impl.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/user_status_repository.dart';

import '../../domain/use_cases/get_user_status_usecase_test.mocks.dart';
import 'dashboard_repository_impl_test.mocks.dart';

@GenerateMocks([UserStatusRemoteDataSource])
void main() {
  late MockUserStatusRepository mockUserStatusRepository;
  late MockUserStatusRemoteDataSource mockUserStatusRemoteDataSource;
  late UserStatusRepositoryImpl dashboardRepositoryImpl;

  setUp(() async {
    mockUserStatusRemoteDataSource = MockUserStatusRemoteDataSource();
    mockUserStatusRepository = MockUserStatusRepository();
    dashboardRepositoryImpl =
        UserStatusRepositoryImpl(mockUserStatusRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for getUserStatus in UserStatus Repository', () {
    test(
      'should return remote data when the call to auth remote data source is successful',
      () async {
        // arrange
        when(mockUserStatusRemoteDataSource.getUserStatus(any))
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
        when(mockUserStatusRemoteDataSource.getUserStatus(any))
            .thenThrow(tServerException);
        // act
        final result = await dashboardRepositoryImpl.getUserStatus(NoParams());
        // assert
        verify(mockUserStatusRemoteDataSource.getUserStatus(NoParams()));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
