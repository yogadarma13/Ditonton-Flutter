import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

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
