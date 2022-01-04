import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

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
