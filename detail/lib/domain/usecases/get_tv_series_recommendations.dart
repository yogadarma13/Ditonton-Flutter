import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class GetTvSeriesRecommendationsUseCase {
  Future<Either<Failure, List<Movie>>> execute(id);
}

class GetTvSeriesRecommendations implements GetTvSeriesRecommendationsUseCase {
  final TvRepository repository;

  GetTvSeriesRecommendations(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getTVSeriesRecommendations(id);
  }
}
