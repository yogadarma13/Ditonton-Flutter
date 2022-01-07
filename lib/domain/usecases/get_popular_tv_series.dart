import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

abstract class GetPopularTvSeriesUseCase {
  Future<Either<Failure, List<Movie>>> execute();
}

class GetPopularTvSeries implements GetPopularTvSeriesUseCase {
  final MovieRepository repository;

  GetPopularTvSeries(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularTVSeries();
  }
}
