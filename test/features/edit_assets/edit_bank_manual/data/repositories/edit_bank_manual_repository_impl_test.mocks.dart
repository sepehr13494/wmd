// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/edit_assets/edit_bank_manual/data/repositories/edit_bank_manual_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i10;
import 'package:wmd/core/error_and_success/succeses.dart' as _i11;
import 'package:wmd/features/edit_assets/edit_bank_manual/data/data_sources/edit_bank_manual_remote_datasource.dart'
    as _i5;
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_params.dart'
    as _i8;
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_response.dart'
    as _i3;
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_params.dart'
    as _i7;
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_response.dart'
    as _i2;
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/repositories/edit_bank_manual_repository.dart'
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

class _FakePutBankManualResponse_0 extends _i1.SmartFake
    implements _i2.PutBankManualResponse {
  _FakePutBankManualResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDeleteBankManualResponse_1 extends _i1.SmartFake
    implements _i3.DeleteBankManualResponse {
  _FakeDeleteBankManualResponse_1(
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

/// A class which mocks [EditBankManualRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockEditBankManualRemoteDataSource extends _i1.Mock
    implements _i5.EditBankManualRemoteDataSource {
  MockEditBankManualRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.PutBankManualResponse> putBankManual(
          _i7.PutBankManualParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #putBankManual,
          [params],
        ),
        returnValue: _i6.Future<_i2.PutBankManualResponse>.value(
            _FakePutBankManualResponse_0(
          this,
          Invocation.method(
            #putBankManual,
            [params],
          ),
        )),
      ) as _i6.Future<_i2.PutBankManualResponse>);
  @override
  _i6.Future<_i3.DeleteBankManualResponse> deleteBankManual(
          _i8.DeleteBankManualParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteBankManual,
          [params],
        ),
        returnValue: _i6.Future<_i3.DeleteBankManualResponse>.value(
            _FakeDeleteBankManualResponse_1(
          this,
          Invocation.method(
            #deleteBankManual,
            [params],
          ),
        )),
      ) as _i6.Future<_i3.DeleteBankManualResponse>);
}

/// A class which mocks [EditBankManualRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEditBankManualRepository extends _i1.Mock
    implements _i9.EditBankManualRepository {
  MockEditBankManualRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>> putBankManual(
          _i7.PutBankManualParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #putBankManual,
          [params],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>.value(
                _FakeEither_2<_i10.Failure, _i11.AppSuccess>(
          this,
          Invocation.method(
            #putBankManual,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>);
  @override
  _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>> deleteBankManual(
          _i8.DeleteBankManualParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteBankManual,
          [params],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>.value(
                _FakeEither_2<_i10.Failure, _i11.AppSuccess>(
          this,
          Invocation.method(
            #deleteBankManual,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i10.Failure, _i11.AppSuccess>>);
}
