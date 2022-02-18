import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

abstract class GetAiringTodayTvSeriesUseCase {
  Future<Either<Failure, List<Movie>>> execute();
}

class GetAiringTodayTvSeries implements GetAiringTodayTvSeriesUseCase {
  final TvRepository repository;

  GetAiringTodayTvSeries(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getAiringTodayTVSeries();
  }
}
