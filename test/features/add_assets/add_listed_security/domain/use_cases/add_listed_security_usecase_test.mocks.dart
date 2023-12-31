// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i5;
import 'package:wmd/features/add_assets/add_listed_security/data/models/listed_security_name.dart'
    as _i8;
import 'package:wmd/features/add_assets/add_listed_security/domain/repositories/listed_security_repository.dart'
    as _i3;
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart'
    as _i7;
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart'
    as _i6;

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

/// A class which mocks [ListedSecurityRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockListedSecurityRepository extends _i1.Mock
    implements _i3.ListedSecurityRepository {
  MockListedSecurityRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AddAsset>> postListedSecurity(
          _i7.AddListedSecurityParams? addListedSecurityParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #postListedSecurity,
          [addListedSecurityParams],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.AddAsset>>.value(
            _FakeEither_0<_i5.Failure, _i6.AddAsset>(
          this,
          Invocation.method(
            #postListedSecurity,
            [addListedSecurityParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.AddAsset>>);
  @override
  _i4.Future<
      _i2.Either<_i5.Failure, List<_i8.ListedSecurityName>>> getListedSecurity(
          String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #getListedSecurity,
          [name],
        ),
        returnValue: _i4.Future<
                _i2.Either<_i5.Failure, List<_i8.ListedSecurityName>>>.value(
            _FakeEither_0<_i5.Failure, List<_i8.ListedSecurityName>>(
          this,
          Invocation.method(
            #getListedSecurity,
            [name],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i8.ListedSecurityName>>>);
}
