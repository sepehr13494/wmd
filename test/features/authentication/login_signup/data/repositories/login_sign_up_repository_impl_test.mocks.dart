// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/authentication/login_signup/data/repositories/login_sign_up_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i11;
import 'package:wmd/core/error_and_success/succeses.dart' as _i12;
import 'package:wmd/features/authentication/login_signup/data/data_sources/login_sign_up_remote_data_source.dart'
    as _i5;
import 'package:wmd/features/authentication/login_signup/data/models/login_response_model.dart'
    as _i2;
import 'package:wmd/features/authentication/login_signup/data/models/register_response_model.dart'
    as _i3;
import 'package:wmd/features/authentication/login_signup/domain/repositories/login_sign_up_repository.dart'
    as _i10;
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart'
    as _i7;
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart'
    as _i8;
import 'package:wmd/features/authentication/login_signup/domain/use_cases/resend_email_usecase.dart'
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

class _FakeLoginResponse_0 extends _i1.SmartFake implements _i2.LoginResponse {
  _FakeLoginResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRegisterResponse_1 extends _i1.SmartFake
    implements _i3.RegisterResponse {
  _FakeRegisterResponse_1(
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

/// A class which mocks [LoginSignUpRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginSignUpRemoteDataSource extends _i1.Mock
    implements _i5.LoginSignUpRemoteDataSource {
  MockLoginSignUpRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.LoginResponse> login(_i7.LoginParams? loginParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [loginParams],
        ),
        returnValue: _i6.Future<_i2.LoginResponse>.value(_FakeLoginResponse_0(
          this,
          Invocation.method(
            #login,
            [loginParams],
          ),
        )),
      ) as _i6.Future<_i2.LoginResponse>);
  @override
  _i6.Future<_i3.RegisterResponse> register(
          _i8.RegisterParams? registerParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [registerParams],
        ),
        returnValue:
            _i6.Future<_i3.RegisterResponse>.value(_FakeRegisterResponse_1(
          this,
          Invocation.method(
            #register,
            [registerParams],
          ),
        )),
      ) as _i6.Future<_i3.RegisterResponse>);
  @override
  _i6.Future<Map<String, dynamic>> resendEmail(
          _i9.ResendEmailParams? resendEmailParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #resendEmail,
          [resendEmailParams],
        ),
        returnValue:
            _i6.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i6.Future<Map<String, dynamic>>);
}

/// A class which mocks [LoginSignUpRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginSignUpRepository extends _i1.Mock
    implements _i10.LoginSignUpRepository {
  MockLoginSignUpRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>> login(
          _i7.LoginParams? loginParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [loginParams],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>>.value(
                _FakeEither_2<_i11.Failure, _i12.AppSuccess>(
          this,
          Invocation.method(
            #login,
            [loginParams],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>>);
  @override
  _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>> register(
          _i8.RegisterParams? registerParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [registerParams],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>>.value(
                _FakeEither_2<_i11.Failure, _i12.AppSuccess>(
          this,
          Invocation.method(
            #register,
            [registerParams],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>>);
  @override
  _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>> resendEmail(
          _i9.ResendEmailParams? resendEmailParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #resendEmail,
          [resendEmailParams],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>>.value(
                _FakeEither_2<_i11.Failure, _i12.AppSuccess>(
          this,
          Invocation.method(
            #resendEmail,
            [resendEmailParams],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i11.Failure, _i12.AppSuccess>>);
}
