// Mocks generated by Mockito 5.3.1 from annotations
// in wmd/test/features/add_assets/add_bank_auto/data/repositories/bank_list_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/domain/usecases/usercase.dart' as _i5;
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/data_sources/bank_list_data_source.dart'
    as _i2;
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/bank_list_response.dart'
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

/// A class which mocks [BankListRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockBankListRemoteDataSource extends _i1.Mock
    implements _i2.BankListRemoteDataSource {
  MockBankListRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.BankResponse>> getBankList(_i5.NoParams? param) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBankList,
          [param],
        ),
        returnValue:
            _i3.Future<List<_i4.BankResponse>>.value(<_i4.BankResponse>[]),
      ) as _i3.Future<List<_i4.BankResponse>>);
  @override
  _i3.Future<List<_i4.BankResponse>> getPopularBankList(int? count) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularBankList,
          [count],
        ),
        returnValue:
            _i3.Future<List<_i4.BankResponse>>.value(<_i4.BankResponse>[]),
      ) as _i3.Future<List<_i4.BankResponse>>);
}
