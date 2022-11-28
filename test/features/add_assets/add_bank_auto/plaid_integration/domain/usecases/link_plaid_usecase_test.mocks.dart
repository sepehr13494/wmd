// Mocks generated by Mockito 5.3.1 from annotations
// in wmd/test/features/add_assets/add_bank_auto/plaid_integration/domain/usecases/link_plaid_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i5;
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/repository/plaid_link_repository.dart'
    as _i3;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PlaidLinkRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlaidLinkRepository extends _i1.Mock
    implements _i3.PlaidLinkRepository {
  MockPlaidLinkRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> getLinkToken(
    String? redirectUrl,
    String? provider,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLinkToken,
          [
            redirectUrl,
            provider,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #getLinkToken,
            [
              redirectUrl,
              provider,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> getPublicToken(
          String? linkToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPublicToken,
          [linkToken],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #getPublicToken,
            [linkToken],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> postPublicToken(
          String? publicToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #postPublicToken,
          [publicToken],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #postPublicToken,
            [publicToken],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
}
