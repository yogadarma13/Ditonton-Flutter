import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

abstract class GetTvSeriesDetailUseCase {
  Future<Either<Failure, MovieDetail>> execute(int id);
}

class GetTvSeriesDetail implements GetTvSeriesDetailUseCase {
  final TvRepository repository;

  GetTvSeriesDetail(this.repository);

  @override
  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
