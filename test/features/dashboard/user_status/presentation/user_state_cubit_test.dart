import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/put_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';

import 'user_state_cubit_test.mocks.dart';

@GenerateMocks([GetUserStatusUseCase, PutUserStatusUseCase])
void main() {
  late MockGetUserStatusUseCase mockGetUserStatusUseCase;
  late MockPutUserStatusUseCase mockPutUserStatusUseCase;
  late UserStatusCubit userStatusCubit;

  setUp(() {
    mockGetUserStatusUseCase = MockGetUserStatusUseCase();
    mockPutUserStatusUseCase = MockPutUserStatusUseCase();
    userStatusCubit =
        UserStatusCubit(mockGetUserStatusUseCase, mockPutUserStatusUseCase);
  });

  final tUserStatus = UserStatus.tUserStatus;

  blocTest(
    'when get userStatus use-case is emits the UserStatusLoaded whe success',
    build: () => userStatusCubit,
    setUp: () => when(mockGetUserStatusUseCase(any))
        .thenAnswer((realInvocation) async => Right(tUserStatus)),
    act: (bloc) async => await bloc.getUserStatus(),
    expect: () =>
        [isA<LoadingState>(), UserStatusLoaded(userStatus: tUserStatus)],
    verify: (_) {
      verify(mockGetUserStatusUseCase(NoParams())).called(1);
    },
  );

  blocTest(
    'when get userStatus use-case is emits the UserStatusLoaded whe success',
    build: () => userStatusCubit,
    setUp: () => when(mockPutUserStatusUseCase(any))
        .thenAnswer((realInvocation) async => Right(tUserStatus)),
    act: (bloc) async =>
        await bloc.putUserStatusUseCase(UserStatus.tUserStatusParam),
    expect: () => [],
    verify: (_) {
      verify(mockPutUserStatusUseCase(UserStatus.tUserStatusParam)).called(1);
    },
  );
}
