import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_params.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_response.dart';
import 'package:wmd/features/settings/linked_accounts/domain/use_cases/delete_linked_accounts_usecase.dart';
import 'package:wmd/features/settings/linked_accounts/domain/use_cases/get_linked_accounts_usecase.dart';
import 'package:wmd/features/settings/linked_accounts/presentation/manager/linked_accounts_cubit.dart';

import 'linked_accounts_cubit_test.mocks.dart';

@GenerateMocks([
  GetLinkedAccountsUseCase,
  DeleteLinkedAccountsUseCase,
])
void main() {
  late MockGetLinkedAccountsUseCase mockGetLinkedAccountsUseCase;
  late MockDeleteLinkedAccountsUseCase mockDeleteLinkedAccountsUseCase;

  late LinkedAccountsCubit linkedAccountsCubit;

  setUp(() {
    mockGetLinkedAccountsUseCase = MockGetLinkedAccountsUseCase();
    mockDeleteLinkedAccountsUseCase = MockDeleteLinkedAccountsUseCase();

    linkedAccountsCubit = LinkedAccountsCubit(
        mockGetLinkedAccountsUseCase, mockDeleteLinkedAccountsUseCase);
  });

  group("getLinkedAccounts", () {
    blocTest(
      'when GetLinkedAccountsUseCase emits the GetLinkedAccountsLoaded when success',
      build: () => linkedAccountsCubit,
      setUp: () => when(mockGetLinkedAccountsUseCase(any)).thenAnswer(
          (realInvocation) async => Right(GetLinkedAccountsResponse.tResponse)),
      act: (bloc) async => await bloc.getLinkedAccounts(),
      expect: () => [
        isA<LoadingState>(),
        GetLinkedAccountsLoaded(
            getLinkedAccountsEntities: GetLinkedAccountsResponse.tResponse)
      ],
      verify: (_) {
        verify(mockGetLinkedAccountsUseCase(GetLinkedAccountsParams.tParams));
      },
    );

    blocTest(
      'when GetLinkedAccountsUseCase emits the ErrorState when error',
      build: () => linkedAccountsCubit,
      setUp: () => when(mockGetLinkedAccountsUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getLinkedAccounts(),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockGetLinkedAccountsUseCase(GetLinkedAccountsParams.tParams));
      },
    );
  });
}
