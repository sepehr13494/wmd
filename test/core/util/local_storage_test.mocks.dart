// Mocks generated by Mockito 5.3.1 from annotations
// in wmd/test/core/util/local_storage_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i3;

import 'package:flutter/material.dart' as _i6;
import 'package:hive_flutter/hive_flutter.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wmd/core/util/local_storage.dart' as _i5;

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

class _FakeBox_0<E> extends _i1.SmartFake implements _i2.Box<E> {
  _FakeBox_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocale_1 extends _i1.SmartFake implements _i3.Locale {
  _FakeLocale_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Box].
///
/// See the documentation for Mockito's code generation for more information.
class MockBox<E> extends _i1.Mock implements _i2.Box<E> {
  MockBox() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Iterable<E> get values => (super.noSuchMethod(
        Invocation.getter(#values),
        returnValue: <E>[],
      ) as Iterable<E>);
  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: '',
      ) as String);
  @override
  bool get isOpen => (super.noSuchMethod(
        Invocation.getter(#isOpen),
        returnValue: false,
      ) as bool);
  @override
  bool get lazy => (super.noSuchMethod(
        Invocation.getter(#lazy),
        returnValue: false,
      ) as bool);
  @override
  Iterable<dynamic> get keys => (super.noSuchMethod(
        Invocation.getter(#keys),
        returnValue: <dynamic>[],
      ) as Iterable<dynamic>);
  @override
  int get length => (super.noSuchMethod(
        Invocation.getter(#length),
        returnValue: 0,
      ) as int);
  @override
  bool get isEmpty => (super.noSuchMethod(
        Invocation.getter(#isEmpty),
        returnValue: false,
      ) as bool);
  @override
  bool get isNotEmpty => (super.noSuchMethod(
        Invocation.getter(#isNotEmpty),
        returnValue: false,
      ) as bool);
  @override
  Iterable<E> valuesBetween({
    dynamic startKey,
    dynamic endKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #valuesBetween,
          [],
          {
            #startKey: startKey,
            #endKey: endKey,
          },
        ),
        returnValue: <E>[],
      ) as Iterable<E>);
  @override
  E? getAt(int? index) => (super.noSuchMethod(Invocation.method(
        #getAt,
        [index],
      )) as E?);
  @override
  Map<dynamic, E> toMap() => (super.noSuchMethod(
        Invocation.method(
          #toMap,
          [],
        ),
        returnValue: <dynamic, E>{},
      ) as Map<dynamic, E>);
  @override
  dynamic keyAt(int? index) => super.noSuchMethod(Invocation.method(
        #keyAt,
        [index],
      ));
  @override
  _i4.Stream<_i2.BoxEvent> watch({dynamic key}) => (super.noSuchMethod(
        Invocation.method(
          #watch,
          [],
          {#key: key},
        ),
        returnValue: _i4.Stream<_i2.BoxEvent>.empty(),
      ) as _i4.Stream<_i2.BoxEvent>);
  @override
  bool containsKey(dynamic key) => (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [key],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<void> put(
    dynamic key,
    E? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            key,
            value,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> putAt(
    int? index,
    E? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #putAt,
          [
            index,
            value,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> putAll(Map<dynamic, E>? entries) => (super.noSuchMethod(
        Invocation.method(
          #putAll,
          [entries],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<int> add(E? value) => (super.noSuchMethod(
        Invocation.method(
          #add,
          [value],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<Iterable<int>> addAll(Iterable<E>? values) => (super.noSuchMethod(
        Invocation.method(
          #addAll,
          [values],
        ),
        returnValue: _i4.Future<Iterable<int>>.value(<int>[]),
      ) as _i4.Future<Iterable<int>>);
  @override
  _i4.Future<void> delete(dynamic key) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [key],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteAt(int? index) => (super.noSuchMethod(
        Invocation.method(
          #deleteAt,
          [index],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteAll(Iterable<dynamic>? keys) => (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [keys],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> compact() => (super.noSuchMethod(
        Invocation.method(
          #compact,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<int> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteFromDisk() => (super.noSuchMethod(
        Invocation.method(
          #deleteFromDisk,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> flush() => (super.noSuchMethod(
        Invocation.method(
          #flush,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [LocalStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalStorage extends _i1.Mock implements _i5.LocalStorage {
  MockLocalStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Box<dynamic> get authBox => (super.noSuchMethod(
        Invocation.getter(#authBox),
        returnValue: _FakeBox_0<dynamic>(
          this,
          Invocation.getter(#authBox),
        ),
      ) as _i2.Box<dynamic>);
  @override
  _i4.Future<void> setTokenAndLogin(dynamic token) => (super.noSuchMethod(
        Invocation.method(
          #setTokenAndLogin,
          [token],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> setOwnerId(dynamic val) => (super.noSuchMethod(
        Invocation.method(
          #setOwnerId,
          [val],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  String getOwnerId() => (super.noSuchMethod(
        Invocation.method(
          #getOwnerId,
          [],
        ),
        returnValue: '',
      ) as String);
  @override
  _i4.Future<void> setLocalAuth(dynamic val) => (super.noSuchMethod(
        Invocation.method(
          #setLocalAuth,
          [val],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  bool getLocalAuth() => (super.noSuchMethod(
        Invocation.method(
          #getLocalAuth,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<void> setRefreshToken(dynamic token) => (super.noSuchMethod(
        Invocation.method(
          #setRefreshToken,
          [token],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  String getRefreshToken() => (super.noSuchMethod(
        Invocation.method(
          #getRefreshToken,
          [],
        ),
        returnValue: '',
      ) as String);
  @override
  _i4.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  String getToken() => (super.noSuchMethod(
        Invocation.method(
          #getToken,
          [],
        ),
        returnValue: '',
      ) as String);
  @override
  _i4.Future<bool> getLogin() => (super.noSuchMethod(
        Invocation.method(
          #getLogin,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i6.ThemeMode getTheme() => (super.noSuchMethod(
        Invocation.method(
          #getTheme,
          [],
        ),
        returnValue: _i6.ThemeMode.system,
      ) as _i6.ThemeMode);
  @override
  _i4.Future<void> setTheme(_i6.ThemeMode? themeMode) => (super.noSuchMethod(
        Invocation.method(
          #setTheme,
          [themeMode],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i3.Locale getLocale() => (super.noSuchMethod(
        Invocation.method(
          #getLocale,
          [],
        ),
        returnValue: _FakeLocale_1(
          this,
          Invocation.method(
            #getLocale,
            [],
          ),
        ),
      ) as _i3.Locale);
  @override
  _i4.Future<void> setLocale(_i3.Locale? locale) => (super.noSuchMethod(
        Invocation.method(
          #setLocale,
          [locale],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
