// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/safe_device/presentation/manager/safe_device_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i6;
import 'package:wmd/core/error_and_success/succeses.dart' as _i7;
import 'package:wmd/features/safe_device/data/models/is_safe_device_params.dart'
    as _i8;
import 'package:wmd/features/safe_device/domain/repositories/safe_device_repository.dart'
    as _i2;
import 'package:wmd/features/safe_device/domain/use_cases/is_safe_device_usecase.dart'
    as _i4;

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

class _FakeSafeDeviceRepository_0 extends _i1.SmartFake
    implements _i2.SafeDeviceRepository {
  _FakeSafeDeviceRepository_0(
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

/// A class which mocks [IsSafeDeviceUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockIsSafeDeviceUseCase extends _i1.Mock
    implements _i4.IsSafeDeviceUseCase {
  MockIsSafeDeviceUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SafeDeviceRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSafeDeviceRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SafeDeviceRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.AppSuccess>> call(
          _i8.IsSafeDeviceParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.AppSuccess>>.value(
            _FakeEither_1<_i6.Failure, _i7.AppSuccess>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.AppSuccess>>);
}
