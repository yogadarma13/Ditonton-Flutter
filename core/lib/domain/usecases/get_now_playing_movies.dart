import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

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
