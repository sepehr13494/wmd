// Mocks generated by Mockito 5.3.1 from annotations
// in wmd/test/features/dashboard/data/repositories/dashboard_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/domain/usecases/usercase.dart' as _i5;
import 'package:wmd/features/dashboard/data/data_sources/dashboard_remote_data_source.dart'
    as _i3;
import 'package:wmd/features/dashboard/data/models/user_status.dart' as _i2;

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

class _FakeUserStatus_0 extends _i1.SmartFake implements _i2.UserStatus {
  _FakeUserStatus_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DashboardRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDashboardRemoteDataSource extends _i1.Mock
    implements _i3.DashboardRemoteDataSource {
  MockDashboardRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserStatus> getUserStatus(_i5.NoParams? noParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserStatus,
          [noParams],
        ),
        returnValue: _i4.Future<_i2.UserStatus>.value(_FakeUserStatus_0(
          this,
          Invocation.method(
            #getUserStatus,
            [noParams],
          ),
        )),
      ) as _i4.Future<_i2.UserStatus>);
  @override
  _i4.Future<_i2.UserStatus> putUserStatus(_i2.UserStatus? userStatusParam) =>
      (super.noSuchMethod(
        Invocation.method(
          #putUserStatus,
          [userStatusParam],
        ),
        returnValue: _i4.Future<_i2.UserStatus>.value(_FakeUserStatus_0(
          this,
          Invocation.method(
            #putUserStatus,
            [userStatusParam],
          ),
        )),
      ) as _i4.Future<_i2.UserStatus>);
}
