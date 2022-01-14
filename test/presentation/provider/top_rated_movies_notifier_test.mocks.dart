// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/provider/top_rated_movies_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i5;
import 'package:ditonton/domain/entities/movie.dart' as _i6;
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart' as _i3;
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [GetTopRatedMoviesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedMoviesUseCase extends _i1.Mock
    implements _i3.GetTopRatedMoviesUseCase {
  MockGetTopRatedMoviesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Movie>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetTopRatedTvSeriesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTvSeriesUseCase extends _i1.Mock
    implements _i7.GetTopRatedTvSeriesUseCase {
  MockGetTopRatedTvSeriesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Movie>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  String toString() => super.toString();
}
