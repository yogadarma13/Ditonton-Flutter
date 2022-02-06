// Mocks generated by Mockito 5.0.17 from annotations
// in ditonton/test/presentation/pages/home_movie_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i10;
import 'package:ditonton/domain/entities/movie.dart' as _i9;
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart'
    as _i3;
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart' as _i2;
import 'package:ditonton/domain/usecases/get_popular_movies.dart' as _i4;
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart' as _i6;
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart' as _i5;
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart' as _i7;
import 'package:ditonton/presentation/provider/movie_list_notifier.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetNowPlayingMoviesUseCase_0 extends _i1.Fake
    implements _i2.GetNowPlayingMoviesUseCase {}

class _FakeGetAiringTodayTvSeriesUseCase_1 extends _i1.Fake
    implements _i3.GetAiringTodayTvSeriesUseCase {}

class _FakeGetPopularMoviesUseCase_2 extends _i1.Fake
    implements _i4.GetPopularMoviesUseCase {}

class _FakeGetTopRatedMoviesUseCase_3 extends _i1.Fake
    implements _i5.GetTopRatedMoviesUseCase {}

class _FakeGetPopularTvSeriesUseCase_4 extends _i1.Fake
    implements _i6.GetPopularTvSeriesUseCase {}

class _FakeGetTopRatedTvSeriesUseCase_5 extends _i1.Fake
    implements _i7.GetTopRatedTvSeriesUseCase {}

/// A class which mocks [MovieListNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieListNotifier extends _i1.Mock implements _i8.MovieListNotifier {
  MockMovieListNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingMoviesUseCase get getNowPlayingMovies =>
      (super.noSuchMethod(Invocation.getter(#getNowPlayingMovies),
              returnValue: _FakeGetNowPlayingMoviesUseCase_0())
          as _i2.GetNowPlayingMoviesUseCase);
  @override
  _i3.GetAiringTodayTvSeriesUseCase get getAiringTodayTvSeries =>
      (super.noSuchMethod(Invocation.getter(#getAiringTodayTvSeries),
              returnValue: _FakeGetAiringTodayTvSeriesUseCase_1())
          as _i3.GetAiringTodayTvSeriesUseCase);
  @override
  _i4.GetPopularMoviesUseCase get getPopularMovies =>
      (super.noSuchMethod(Invocation.getter(#getPopularMovies),
              returnValue: _FakeGetPopularMoviesUseCase_2())
          as _i4.GetPopularMoviesUseCase);
  @override
  _i5.GetTopRatedMoviesUseCase get getTopRatedMovies =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedMovies),
              returnValue: _FakeGetTopRatedMoviesUseCase_3())
          as _i5.GetTopRatedMoviesUseCase);
  @override
  _i6.GetPopularTvSeriesUseCase get getPopularTvSeries =>
      (super.noSuchMethod(Invocation.getter(#getPopularTvSeries),
              returnValue: _FakeGetPopularTvSeriesUseCase_4())
          as _i6.GetPopularTvSeriesUseCase);
  @override
  _i7.GetTopRatedTvSeriesUseCase get getTopRatedTvSeries =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedTvSeries),
              returnValue: _FakeGetTopRatedTvSeriesUseCase_5())
          as _i7.GetTopRatedTvSeriesUseCase);
  @override
  List<_i9.Movie> get nowPlayingMovies =>
      (super.noSuchMethod(Invocation.getter(#nowPlayingMovies),
          returnValue: <_i9.Movie>[]) as List<_i9.Movie>);
  @override
  _i10.RequestState get nowPlayingState =>
      (super.noSuchMethod(Invocation.getter(#nowPlayingState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  List<_i9.Movie> get popularMovies =>
      (super.noSuchMethod(Invocation.getter(#popularMovies),
          returnValue: <_i9.Movie>[]) as List<_i9.Movie>);
  @override
  _i10.RequestState get popularMoviesState =>
      (super.noSuchMethod(Invocation.getter(#popularMoviesState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  List<_i9.Movie> get topRatedMovies =>
      (super.noSuchMethod(Invocation.getter(#topRatedMovies),
          returnValue: <_i9.Movie>[]) as List<_i9.Movie>);
  @override
  _i10.RequestState get topRatedMoviesState =>
      (super.noSuchMethod(Invocation.getter(#topRatedMoviesState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i11.Future<void> fetchNowPlayingMovies(_i10.CategoryMovie? category) =>
      (super.noSuchMethod(Invocation.method(#fetchNowPlayingMovies, [category]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> fetchPopularMovies(_i10.CategoryMovie? category) =>
      (super.noSuchMethod(Invocation.method(#fetchPopularMovies, [category]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> fetchTopRatedMovies(_i10.CategoryMovie? category) =>
      (super.noSuchMethod(Invocation.method(#fetchTopRatedMovies, [category]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
