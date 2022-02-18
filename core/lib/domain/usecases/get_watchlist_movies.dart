import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

abstract class GetWatchlistMoviesUseCase {
  Future<Either<Failure, List<Movie>>> execute(String category);
}

class GetWatchlistMovies implements GetWatchlistMoviesUseCase {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(String category) {
    return _repository.getWatchlistMovies(category);
  }
}
