import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];

  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistTvSeries = <Movie>[];

  List<Movie> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  var _watchlistTvState = RequestState.Empty;

  RequestState get watchlistTvState => _watchlistTvState;

  String _message = '';

  String get message => _message;

  final GetWatchlistMoviesUseCase getWatchlistMovies;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute(CategoryMovie.Movies.name);
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();

    final result =
        await getWatchlistMovies.execute(CategoryMovie.TvSeries.name);
    result.fold(
      (failure) {
        _watchlistTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistTvState = RequestState.Loaded;
        _watchlistTvSeries = tvData;
        notifyListeners();
      },
    );
  }
}
