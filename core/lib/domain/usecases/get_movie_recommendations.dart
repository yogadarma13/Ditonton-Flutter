import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

abstract class GetMovieRecommendationsUseCase {
  Future<Either<Failure, List<Movie>>> execute(id);
}

class GetMovieRecommendations implements GetMovieRecommendationsUseCase {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
