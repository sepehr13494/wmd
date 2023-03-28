// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/dashboard/performance_table/presentation/manager/performance_table_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i6;
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_params.dart'
    as _i8;
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_params.dart'
    as _i11;
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_params.dart'
    as _i14;
import 'package:wmd/features/dashboard/performance_table/domain/entities/get_asset_class_entity.dart'
    as _i7;
import 'package:wmd/features/dashboard/performance_table/domain/entities/get_benchmark_entity.dart'
    as _i10;
import 'package:wmd/features/dashboard/performance_table/domain/entities/get_custodian_performance_entity.dart'
    as _i13;
import 'package:wmd/features/dashboard/performance_table/domain/repositories/performance_table_repository.dart'
    as _i2;
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_asset_class_usecase.dart'
    as _i4;
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_benchmark_usecase.dart'
    as _i9;
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_custodian_performance_usecase.dart'
    as _i12;

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

class _FakePerformanceTableRepository_0 extends _i1.SmartFake
    implements _i2.PerformanceTableRepository {
  _FakePerformanceTableRepository_0(
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

/// A class which mocks [GetAssetClassUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAssetClassUseCase extends _i1.Mock
    implements _i4.GetAssetClassUseCase {
  MockGetAssetClassUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PerformanceTableRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakePerformanceTableRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.PerformanceTableRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.GetAssetClassEntity>>> call(
          _i8.GetAssetClassParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<
                _i3.Either<_i6.Failure, List<_i7.GetAssetClassEntity>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.GetAssetClassEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.GetAssetClassEntity>>>);
}

/// A class which mocks [GetBenchmarkUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetBenchmarkUseCase extends _i1.Mock
    implements _i9.GetBenchmarkUseCase {
  MockGetBenchmarkUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PerformanceTableRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakePerformanceTableRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.PerformanceTableRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i10.GetBenchmarkEntity>>> call(
          _i11.GetBenchmarkParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<
                _i3.Either<_i6.Failure, List<_i10.GetBenchmarkEntity>>>.value(
            _FakeEither_1<_i6.Failure, List<_i10.GetBenchmarkEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i10.GetBenchmarkEntity>>>);
}

/// A class which mocks [GetCustodianPerformanceUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCustodianPerformanceUseCase extends _i1.Mock
    implements _i12.GetCustodianPerformanceUseCase {
  MockGetCustodianPerformanceUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PerformanceTableRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakePerformanceTableRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.PerformanceTableRepository);
  @override
  _i5.Future<
      _i3.Either<_i6.Failure, List<_i13.GetCustodianPerformanceEntity>>> call(
          _i14.GetCustodianPerformanceParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<
            _i3.Either<_i6.Failure,
                List<_i13.GetCustodianPerformanceEntity>>>.value(_FakeEither_1<
            _i6.Failure, List<_i13.GetCustodianPerformanceEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<
          _i3.Either<_i6.Failure, List<_i13.GetCustodianPerformanceEntity>>>);
}
