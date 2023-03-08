// Mocks generated by Mockito 5.3.2 from annotations
// in wmd/test/features/assets_overview/assets_geography_chart/data/repositories/assets_geography_chart_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/error_and_success/failures.dart' as _i8;
import 'package:wmd/features/assets_overview/assets_geography_chart/data/data_sources/assets_geography_chart_remote_datasource.dart'
    as _i3;
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_params.dart'
    as _i6;
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_response.dart'
    as _i5;
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/entities/get_assets_geography_entity.dart'
    as _i9;
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/repositories/assets_geography_chart_repository.dart'
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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AssetsGeographyChartRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAssetsGeographyChartRemoteDataSource extends _i1.Mock
    implements _i3.AssetsGeographyChartRemoteDataSource {
  MockAssetsGeographyChartRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.GetAssetsGeographyResponse>> getAssetsGeography(
          _i6.GetAssetsGeographyParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAssetsGeography,
          [params],
        ),
        returnValue: _i4.Future<List<_i5.GetAssetsGeographyResponse>>.value(
            <_i5.GetAssetsGeographyResponse>[]),
      ) as _i4.Future<List<_i5.GetAssetsGeographyResponse>>);
}

/// A class which mocks [AssetsGeographyChartRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAssetsGeographyChartRepository extends _i1.Mock
    implements _i7.AssetsGeographyChartRepository {
  MockAssetsGeographyChartRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i8.Failure, List<_i9.GetAssetsGeographyEntity>>>
      getAssetsGeography(_i6.GetAssetsGeographyParams? params) =>
          (super.noSuchMethod(
            Invocation.method(
              #getAssetsGeography,
              [params],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i8.Failure,
                        List<_i9.GetAssetsGeographyEntity>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.GetAssetsGeographyEntity>>(
              this,
              Invocation.method(
                #getAssetsGeography,
                [params],
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i8.Failure, List<_i9.GetAssetsGeographyEntity>>>);
}
