import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

abstract class GetTopRatedMoviesUseCase {
  Future<Either<Failure, List<Movie>>> execute();
}

class GetTopRatedMovies implements GetTopRatedMoviesUseCase {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
