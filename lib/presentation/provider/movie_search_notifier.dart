import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMoviesUseCase searchMovies;
  final SearchTvSeriesUseCase searchTvSeries;

  MovieSearchNotifier({
    required this.searchMovies,
    required this.searchTvSeries,
  });

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _searchResult = [];

  List<Movie> get searchResult => _searchResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchMovieSearch(String query, CategoryMovie category) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = category == CategoryMovie.Movies
        ? await searchMovies.execute(query)
        : await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
