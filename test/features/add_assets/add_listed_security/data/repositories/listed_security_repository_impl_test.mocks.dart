// Mocks generated by Mockito 5.3.1 from annotations
// in wmd/test/features/add_assets/add_listed_security/data/repositories/listed_security_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/features/add_assets/add_listed_security/data/data_sources/listed_security_remote_data_source.dart'
    as _i3;
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart'
    as _i5;
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart'
    as _i2;

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

class _FakeAddAssetModel_0 extends _i1.SmartFake implements _i2.AddAssetModel {
  _FakeAddAssetModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ListedSecurityRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockListedSecurityRemoteDataSource extends _i1.Mock
    implements _i3.ListedSecurityRemoteDataSource {
  MockListedSecurityRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.AddAssetModel> postListedSecurity(
          _i5.AddListedSecurityParams? addListedSecurityParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #postListedSecurity,
          [addListedSecurityParams],
        ),
        returnValue: _i4.Future<_i2.AddAssetModel>.value(_FakeAddAssetModel_0(
          this,
          Invocation.method(
            #postListedSecurity,
            [addListedSecurityParams],
          ),
        )),
      ) as _i4.Future<_i2.AddAssetModel>);
}
