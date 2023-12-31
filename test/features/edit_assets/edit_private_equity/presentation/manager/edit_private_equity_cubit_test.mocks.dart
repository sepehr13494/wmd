// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/edit_assets/edit_private_equity/presentation/manager/edit_private_equity_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i7;
import 'package:wmd/core/error_and_success/succeses.dart' as _i8;
import 'package:wmd/core/util/local_storage.dart' as _i3;
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/delete_private_equity_params.dart'
    as _i10;
import 'package:wmd/features/edit_assets/edit_private_equity/domain/repositories/edit_private_equity_repository.dart'
    as _i2;
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/delete_private_equity_usecase.dart'
    as _i9;
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/put_private_equity_usecase.dart'
    as _i5;

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

class _FakeEditPrivateEquityRepository_0 extends _i1.SmartFake
    implements _i2.EditPrivateEquityRepository {
  _FakeEditPrivateEquityRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocalStorage_1 extends _i1.SmartFake implements _i3.LocalStorage {
  _FakeLocalStorage_1(
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

/// A class which mocks [PutPrivateEquityUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPutPrivateEquityUseCase extends _i1.Mock
    implements _i5.PutPrivateEquityUseCase {
  MockPutPrivateEquityUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.EditPrivateEquityRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeEditPrivateEquityRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.EditPrivateEquityRepository);
  @override
  _i3.LocalStorage get localStorage => (super.noSuchMethod(
        Invocation.getter(#localStorage),
        returnValue: _FakeLocalStorage_1(
          this,
          Invocation.getter(#localStorage),
        ),
      ) as _i3.LocalStorage);
  @override
  _i6.Future<_i4.Either<_i7.Failure, _i8.AppSuccess>> call(
    Map<String, dynamic>? params,
    String? assetId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [
            params,
            assetId,
          ],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, _i8.AppSuccess>>.value(
            _FakeEither_2<_i7.Failure, _i8.AppSuccess>(
          this,
          Invocation.method(
            #call,
            [
              params,
              assetId,
            ],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, _i8.AppSuccess>>);
}

/// A class which mocks [DeletePrivateEquityUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeletePrivateEquityUseCase extends _i1.Mock
    implements _i9.DeletePrivateEquityUseCase {
  MockDeletePrivateEquityUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.EditPrivateEquityRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeEditPrivateEquityRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.EditPrivateEquityRepository);
  @override
  _i6.Future<_i4.Either<_i7.Failure, _i8.AppSuccess>> call(
          _i10.DeletePrivateEquityParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i6.Future<_i4.Either<_i7.Failure, _i8.AppSuccess>>.value(
            _FakeEither_2<_i7.Failure, _i8.AppSuccess>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, _i8.AppSuccess>>);
}
