import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

abstract class GetTvSeriesRecommendationsUseCase {
  Future<Either<Failure, List<Movie>>> execute(id);
}

class GetTvSeriesRecommendations implements GetTvSeriesRecommendationsUseCase {
  final MovieRepository repository;

  GetTvSeriesRecommendations(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getTVSeriesRecommendations(id);
  }
}
