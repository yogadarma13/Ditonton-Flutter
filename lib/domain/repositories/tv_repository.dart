import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Movie>>> getAiringTodayTVSeries();

  Future<Either<Failure, List<Movie>>> getPopularTVSeries();

  Future<Either<Failure, List<Movie>>> getTopRatedTVSeries();

  Future<Either<Failure, MovieDetail>> getTVSeriesDetail(int id);

  Future<Either<Failure, List<Movie>>> getTVSeriesRecommendations(int id);

  Future<Either<Failure, List<Movie>>> searchTVSeries(String query);
}
