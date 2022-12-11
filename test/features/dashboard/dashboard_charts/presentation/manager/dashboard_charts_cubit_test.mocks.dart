// Mocks generated by Mockito 5.3.1 from annotations
// in wmd/test/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/domain/usecases/usercase.dart' as _i9;
import 'package:wmd/core/error_and_success/failures.dart' as _i7;
import 'package:wmd/core/util/local_storage.dart' as _i3;
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_allocation_entity.dart'
    as _i8;
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_geographic_entity.dart'
    as _i11;
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_pie_entity.dart'
    as _i13;
import 'package:wmd/features/dashboard/dashboard_charts/domain/repositories/dashboard_charts_repository.dart'
    as _i2;
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_allocation_usecase.dart'
    as _i5;
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_geographic_usecase.dart'
    as _i10;
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_pie_usecase.dart'
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

class _FakeDashboardChartsRepository_0 extends _i1.SmartFake
    implements _i2.DashboardChartsRepository {
  _FakeDashboardChartsRepository_0(
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

/// A class which mocks [GetAllocationUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllocationUseCase extends _i1.Mock
    implements _i5.GetAllocationUseCase {
  MockGetAllocationUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DashboardChartsRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDashboardChartsRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.DashboardChartsRepository);
  @override
  _i3.LocalStorage get localStorage => (super.noSuchMethod(
        Invocation.getter(#localStorage),
        returnValue: _FakeLocalStorage_1(
          this,
          Invocation.getter(#localStorage),
        ),
      ) as _i3.LocalStorage);
  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i8.GetAllocationEntity>>> call(
          _i9.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i6.Future<
                _i4.Either<_i7.Failure, List<_i8.GetAllocationEntity>>>.value(
            _FakeEither_2<_i7.Failure, List<_i8.GetAllocationEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, List<_i8.GetAllocationEntity>>>);
}

/// A class which mocks [GetGeographicUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetGeographicUseCase extends _i1.Mock
    implements _i10.GetGeographicUseCase {
  MockGetGeographicUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DashboardChartsRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDashboardChartsRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.DashboardChartsRepository);
  @override
  _i3.LocalStorage get localStorage => (super.noSuchMethod(
        Invocation.getter(#localStorage),
        returnValue: _FakeLocalStorage_1(
          this,
          Invocation.getter(#localStorage),
        ),
      ) as _i3.LocalStorage);
  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i11.GetGeographicEntity>>> call(
          _i9.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i6.Future<
                _i4.Either<_i7.Failure, List<_i11.GetGeographicEntity>>>.value(
            _FakeEither_2<_i7.Failure, List<_i11.GetGeographicEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, List<_i11.GetGeographicEntity>>>);
}

/// A class which mocks [GetPieUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPieUseCase extends _i1.Mock implements _i12.GetPieUseCase {
  MockGetPieUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DashboardChartsRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDashboardChartsRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.DashboardChartsRepository);
  @override
  _i3.LocalStorage get localStorage => (super.noSuchMethod(
        Invocation.getter(#localStorage),
        returnValue: _FakeLocalStorage_1(
          this,
          Invocation.getter(#localStorage),
        ),
      ) as _i3.LocalStorage);
  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i13.GetPieEntity>>> call(
          _i9.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i6.Future<_i4.Either<_i7.Failure, List<_i13.GetPieEntity>>>.value(
                _FakeEither_2<_i7.Failure, List<_i13.GetPieEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, List<_i13.GetPieEntity>>>);
}
