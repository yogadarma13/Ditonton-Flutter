import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Movie>>> getAiringTodayTVSeries();

  Future<Either<Failure, List<Movie>>> getPopularTVSeries();

  Future<Either<Failure, List<Movie>>> getTopRatedTVSeries();

  Future<Either<Failure, MovieDetail>> getTVSeriesDetail(int id);

  Future<Either<Failure, List<Movie>>> getTVSeriesRecommendations(int id);

  Future<Either<Failure, List<Movie>>> searchTVSeries(String query);
}
