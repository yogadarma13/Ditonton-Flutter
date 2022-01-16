// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i19;
import 'dart:typed_data' as _i20;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i8;
import 'package:ditonton/common/network_info.dart' as _i18;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i16;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i14;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i11;
import 'package:ditonton/data/models/movie_detail_model.dart' as _i3;
import 'package:ditonton/data/models/movie_model.dart' as _i12;
import 'package:ditonton/data/models/movie_table.dart' as _i15;
import 'package:ditonton/data/models/tv_detail_response.dart' as _i4;
import 'package:ditonton/data/models/tv_model.dart' as _i13;
import 'package:ditonton/domain/entities/movie.dart' as _i9;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i10;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i6;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i17;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvDetailResponse_2 extends _i1.Fake implements _i4.TvDetailResponse {
}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.MovieDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i10.MovieDetail? movie, String? category) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie, category]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>
      getAiringTodayTVSeries() =>
          (super.noSuchMethod(Invocation.method(#getAiringTodayTVSeries, []),
                  returnValue:
                      Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                          _FakeEither_0<_i8.Failure, List<_i9.Movie>>()))
              as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularTVSeries, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTVSeries, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getTVSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.MovieDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>
      getTVSeriesRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTVSeriesRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchTVSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVSeries, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i11.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
      as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
      as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i12.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i13.TvModel>> getAiringTodayTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getAiringTodayTVSeries, []),
              returnValue: Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
          as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<List<_i13.TvModel>> getPopularTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularTVSeries, []),
              returnValue: Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
          as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<List<_i13.TvModel>> getTopRatedTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTVSeries, []),
              returnValue: Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
          as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<_i4.TvDetailResponse> getTVSeriesDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesDetail, [id]),
              returnValue:
                  Future<_i4.TvDetailResponse>.value(_FakeTvDetailResponse_2()))
          as _i7.Future<_i4.TvDetailResponse>);
  @override
  _i7.Future<List<_i13.TvModel>> getTVSeriesRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesRecommendations, [id]),
              returnValue: Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
          as _i7.Future<List<_i13.TvModel>>);
  @override
  _i7.Future<List<_i13.TvModel>> searchTVSeries(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVSeries, [query]),
              returnValue: Future<List<_i13.TvModel>>.value(<_i13.TvModel>[]))
          as _i7.Future<List<_i13.TvModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i14.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(
          _i15.MovieTable? movie, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertWatchlist, [movie, category]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i15.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i15.MovieTable?>.value())
          as _i7.Future<_i15.MovieTable?>);
  @override
  _i7.Future<List<_i15.MovieTable>> getWatchlistMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, [category]),
              returnValue:
                  Future<List<_i15.MovieTable>>.value(<_i15.MovieTable>[]))
          as _i7.Future<List<_i15.MovieTable>>);
  @override
  _i7.Future<void> cacheNowPlayingMovies(List<_i15.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i15.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i15.MovieTable>>.value(<_i15.MovieTable>[]))
          as _i7.Future<List<_i15.MovieTable>>);
  @override
  _i7.Future<void> cacheAiringTodayTvSeries(List<_i15.MovieTable>? movies) =>
      (super.noSuchMethod(
          Invocation.method(#cacheAiringTodayTvSeries, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i15.MovieTable>> getCachedAiringTodayTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getCachedAiringTodayTvSeries, []),
              returnValue:
                  Future<List<_i15.MovieTable>>.value(<_i15.MovieTable>[]))
          as _i7.Future<List<_i15.MovieTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i16.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i17.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i17.Database?>.value())
          as _i7.Future<_i17.Database?>);
  @override
  _i7.Future<void> insertCacheTransaction(
          List<_i15.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransaction, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertWatchlist(_i15.MovieTable? movie, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertWatchlist, [movie, category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i18.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i19.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i20.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i20.Uint8List>.value(_i20.Uint8List(0)))
          as _i7.Future<_i20.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
