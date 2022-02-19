import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

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
