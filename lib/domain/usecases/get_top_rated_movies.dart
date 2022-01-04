import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

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
