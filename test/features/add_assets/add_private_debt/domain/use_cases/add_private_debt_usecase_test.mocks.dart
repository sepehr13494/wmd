// Mocks generated by Mockito 5.3.1 from annotations
// in wmd/test/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i5;
import 'package:wmd/features/add_assets/add_private_debt/domain/repositories/private_debt_repository.dart'
    as _i3;
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart'
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

/// A class which mocks [PrivateDebtRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPrivateDebtRepository extends _i1.Mock
    implements _i3.PrivateDebtRepository {
  MockPrivateDebtRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AddAsset>> postPrivateDebt(
          _i7.AddPrivateDebtParams? addPrivateDebtParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #postPrivateDebt,
          [addPrivateDebtParams],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.AddAsset>>.value(
            _FakeEither_0<_i5.Failure, _i6.AddAsset>(
          this,
          Invocation.method(
            #postPrivateDebt,
            [addPrivateDebtParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.AddAsset>>);
}