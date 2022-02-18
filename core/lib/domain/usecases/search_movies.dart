import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

abstract class SearchMoviesUseCase {
  Future<Either<Failure, List<Movie>>> execute(String query);
}

class SearchMovies implements SearchMoviesUseCase {
  final MovieRepository repository;

  SearchMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
