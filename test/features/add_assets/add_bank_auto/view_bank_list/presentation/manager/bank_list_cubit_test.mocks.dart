// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/domain/usecases/usercase.dart' as _i9;
import 'package:wmd/core/error_and_success/failures.dart' as _i7;
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/entity/bank_entity.dart'
    as _i5;
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/repository/bank_list_repository.dart'
    as _i2;
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_bank_list.dart'
    as _i4;
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_popular_bank_list.dart'
    as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBankListRepository_0 extends _i1.SmartFake
    implements _i2.BankListRepository {
  _FakeBankListRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetBankListsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetBankListsUseCase extends _i1.Mock
    implements _i4.GetBankListsUseCase {
  MockGetBankListsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BankListRepository get bankListRepository => (super.noSuchMethod(
        Invocation.getter(#bankListRepository),
        returnValue: _FakeBankListRepository_0(
          this,
          Invocation.getter(#bankListRepository),
        ),
      ) as _i2.BankListRepository);
  @override
  set banks(List<_i5.BankEntity>? _banks) => super.noSuchMethod(
        Invocation.setter(
          #banks,
          _banks,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i5.BankEntity>>> call(
          String? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i5.BankEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i5.BankEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i5.BankEntity>>>);
}

/// A class which mocks [GetPopularBankListUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularBankListUseCase extends _i1.Mock
    implements _i8.GetPopularBankListUseCase {
  MockGetPopularBankListUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BankListRepository get bankListRepository => (super.noSuchMethod(
        Invocation.getter(#bankListRepository),
        returnValue: _FakeBankListRepository_0(
          this,
          Invocation.getter(#bankListRepository),
        ),
      ) as _i2.BankListRepository);
  @override
  set banks(List<_i5.BankEntity>? _banks) => super.noSuchMethod(
        Invocation.setter(
          #banks,
          _banks,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i5.BankEntity>>> call(
          _i9.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i5.BankEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i5.BankEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i5.BankEntity>>>);
}
