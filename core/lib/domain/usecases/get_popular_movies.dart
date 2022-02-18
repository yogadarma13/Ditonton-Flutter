import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

abstract class GetPopularMoviesUseCase {
  Future<Either<Failure, List<Movie>>> execute();
}

class GetPopularMovies implements GetPopularMoviesUseCase {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
