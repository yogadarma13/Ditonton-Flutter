import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/tv_repository.dart';

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
