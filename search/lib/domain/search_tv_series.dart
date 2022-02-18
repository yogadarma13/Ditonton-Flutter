import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

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
