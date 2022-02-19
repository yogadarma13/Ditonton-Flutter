import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

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
