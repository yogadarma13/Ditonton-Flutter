import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

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
