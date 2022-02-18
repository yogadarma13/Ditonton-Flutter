import '../../utils/exception.dart';
import '../models/movie_table.dart';
import 'db/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie, String category);

  Future<String> removeWatchlist(MovieTable movie);

  Future<MovieTable?> getMovieById(int id);

  Future<List<MovieTable>> getWatchlistMovies(String category);

  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);

  Future<List<MovieTable>> getCachedNowPlayingMovies();

  // TV SERIES
  Future<void> cacheAiringTodayTvSeries(List<MovieTable> movies);

  Future<List<MovieTable>> getCachedAiringTodayTvSeries();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie, String category) async {
    try {
      await databaseHelper.insertWatchlist(movie, category);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies(String category) async {
    final result = await databaseHelper.getWatchlistMovies(category);
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheAiringTodayTvSeries(List<MovieTable> movies) async {
    await databaseHelper.clearCache('airing today');
    await databaseHelper.insertCacheTransaction(movies, 'airing today');
  }

  @override
  Future<List<MovieTable>> getCachedAiringTodayTvSeries() async {
    final resultList = await databaseHelper.getCacheMovies('airing today');

    if (resultList.isNotEmpty) {
      return resultList.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
