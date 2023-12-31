// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/tfo_login/data/repositories/tfo_login_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i10;
import 'package:wmd/core/error_and_success/succeses.dart' as _i11;
import 'package:wmd/features/add_assets/tfo_login/data/data_sources/tfo_login_remote_datasource.dart'
    as _i5;
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_params.dart'
    as _i7;
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_response.dart'
    as _i2;
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_params.dart'
    as _i8;
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_response.dart'
    as _i3;
import 'package:wmd/features/add_assets/tfo_login/domain/repositories/tfo_login_repository.dart'
    as _i9;

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

class _FakeGetMandatesResponse_0 extends _i1.SmartFake
    implements _i2.GetMandatesResponse {
  _FakeGetMandatesResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoginTfoAccountResponse_1 extends _i1.SmartFake
    implements _i3.LoginTfoAccountResponse {
  _FakeLoginTfoAccountResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TfoLoginRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTfoLoginRemoteDataSource extends _i1.Mock
    implements _i5.TfoLoginRemoteDataSource {
  MockTfoLoginRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.GetMandatesResponse> getMandates(
          _i7.GetMandatesParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMandates,
          [params],
        ),
        returnValue: _i6.Future<_i2.GetMandatesResponse>.value(
            _FakeGetMandatesResponse_0(
          this,
          Invocation.method(
            #getMandates,
            [params],
          ),
        )),
      ) as _i6.Future<_i2.GetMandatesResponse>);
  @override
  _i6.Future<_i3.LoginTfoAccountResponse> loginTfoAccount(
          _i8.LoginTfoAccountParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginTfoAccount,
          [params],
        ),
        returnValue: _i6.Future<_i3.LoginTfoAccountResponse>.value(
            _FakeLoginTfoAccountResponse_1(
          this,
          Invocation.method(
            #loginTfoAccount,
            [params],
          ),
        )),
      ) as _i6.Future<_i3.LoginTfoAccountResponse>);
}

/// A class which mocks [TfoLoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTfoLoginRepository extends _i1.Mock
    implements _i9.TfoLoginRepository {
  MockTfoLoginRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>> getMandates(
          _i7.GetMandatesParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMandates,
          [params],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>.value(
                _FakeEither_2<_i10.Failure, _i11.AppSuccess>(
          this,
          Invocation.method(
            #getMandates,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>);
  @override
  _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>> loginTfoAccount(
          _i8.LoginTfoAccountParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginTfoAccount,
          [params],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>.value(
                _FakeEither_2<_i10.Failure, _i11.AppSuccess>(
          this,
          Invocation.method(
            #loginTfoAccount,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>);
}
