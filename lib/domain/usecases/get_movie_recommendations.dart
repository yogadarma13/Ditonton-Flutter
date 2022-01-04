import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

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
