import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

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
