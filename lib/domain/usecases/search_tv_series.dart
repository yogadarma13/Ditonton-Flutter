import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

abstract class SearchTvSeriesUseCase {
  Future<Either<Failure, List<Movie>>> execute(String query);
}

class SearchTvSeries implements SearchTvSeriesUseCase {
  final MovieRepository repository;

  SearchTvSeries(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchTVSeries(query);
  }
}
