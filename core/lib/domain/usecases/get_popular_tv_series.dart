import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

abstract class GetPopularTvSeriesUseCase {
  Future<Either<Failure, List<Movie>>> execute();
}

class GetPopularTvSeries implements GetPopularTvSeriesUseCase {
  final TvRepository repository;

  GetPopularTvSeries(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularTVSeries();
  }
}
