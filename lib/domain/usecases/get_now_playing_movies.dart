import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

abstract class GetNowPlayingMoviesUseCase {
  Future<Either<Failure, List<Movie>>> execute();
}

class GetNowPlayingMovies implements GetNowPlayingMoviesUseCase {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
