import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist_movies', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(
              testMovieTable, CategoryMovie.Movies.name))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(
          testMovieTable, CategoryMovie.Movies.name);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(
              testMovieTable, CategoryMovie.Movies.name))
          .thenThrow(Exception());
      // act
      final call =
          dataSource.insertWatchlist(testMovieTable, CategoryMovie.Movies.name);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist_movies', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist_movies movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies(CategoryMovie.Movies.name))
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result =
          await dataSource.getWatchlistMovies(CategoryMovie.Movies.name);
      // assert
      expect(result, [testMovieTable]);
    });
  });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('now playing'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingMovies([testMovieCache]);
      // assert
      verify(mockDatabaseHelper.clearCache('now playing'));
      verify(mockDatabaseHelper
          .insertCacheTransaction([testMovieCache], 'now playing'));
    });

    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => [testMovieCacheMap]);
      // act
      final result = await dataSource.getCachedNowPlayingMovies();
      // assert
      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache airing today tv series', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('airing today'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheAiringTodayTvSeries([testTvCache]);
      // assert
      verify(mockDatabaseHelper.clearCache('airing today'));
      verify(mockDatabaseHelper
          .insertCacheTransaction([testTvCache], 'airing today'));
    });

    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('airing today'))
          .thenAnswer((_) async => [testTvCacheMap]);
      // act
      final result = await dataSource.getCachedAiringTodayTvSeries();
      // assert
      expect(result, [testTvCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheMovies('airing today'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedAiringTodayTvSeries();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
