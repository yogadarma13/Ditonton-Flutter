import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/tv_repository.dart';

abstract class SearchTvSeriesUseCase {
  Future<Either<Failure, List<Movie>>> execute(String query);
}

class SearchTvSeries implements SearchTvSeriesUseCase {
  final TvRepository repository;

  SearchTvSeries(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchTVSeries(query);
  }
}
