// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/force_update/data/repositories/force_update_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i8;
import 'package:wmd/features/force_update/data/data_sources/force_update_remote_datasource.dart'
    as _i4;
import 'package:wmd/features/force_update/data/models/get_force_update_params.dart'
    as _i6;
import 'package:wmd/features/force_update/data/models/get_force_update_response.dart'
    as _i2;
import 'package:wmd/features/force_update/domain/entities/get_force_update_entity.dart'
    as _i9;
import 'package:wmd/features/force_update/domain/repositories/force_update_repository.dart'
    as _i7;

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

class _FakeGetForceUpdateResponse_0 extends _i1.SmartFake
    implements _i2.GetForceUpdateResponse {
  _FakeGetForceUpdateResponse_0(
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

/// A class which mocks [ForceUpdateRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockForceUpdateRemoteDataSource extends _i1.Mock
    implements _i4.ForceUpdateRemoteDataSource {
  MockForceUpdateRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.GetForceUpdateResponse> getForceUpdate(
          _i6.GetForceUpdateParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getForceUpdate,
          [params],
        ),
        returnValue: _i5.Future<_i2.GetForceUpdateResponse>.value(
            _FakeGetForceUpdateResponse_0(
          this,
          Invocation.method(
            #getForceUpdate,
            [params],
          ),
        )),
      ) as _i5.Future<_i2.GetForceUpdateResponse>);
}

/// A class which mocks [ForceUpdateRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockForceUpdateRepository extends _i1.Mock
    implements _i7.ForceUpdateRepository {
  MockForceUpdateRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Either<_i8.Failure, _i9.GetForceUpdateEntity>> getForceUpdate(
          _i6.GetForceUpdateParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getForceUpdate,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i8.Failure, _i9.GetForceUpdateEntity>>.value(
                _FakeEither_1<_i8.Failure, _i9.GetForceUpdateEntity>(
          this,
          Invocation.method(
            #getForceUpdate,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i8.Failure, _i9.GetForceUpdateEntity>>);
}
