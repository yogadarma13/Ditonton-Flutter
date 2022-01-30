import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

abstract class GetTopRatedTvSeriesUseCase {
  Future<Either<Failure, List<Movie>>> execute();
}

class GetTopRatedTvSeries implements GetTopRatedTvSeriesUseCase {
  final TvRepository repository;

  GetTopRatedTvSeries(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedTVSeries();
  }
}
