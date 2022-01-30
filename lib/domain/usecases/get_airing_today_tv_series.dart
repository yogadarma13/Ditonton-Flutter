import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

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
