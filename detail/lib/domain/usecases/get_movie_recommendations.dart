import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

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
