import 'package:core/common/network_info.dart';
import 'package:core/data/datasources/client/IOHttpClient.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/get_airing_today_tv_series.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/detail/detail_movie/detail_bloc.dart';
import 'package:core/presentation/bloc/detail/recommendation/recommendation_bloc.dart';
import 'package:core/presentation/bloc/detail/watchlist/watchlist_bloc.dart';
import 'package:core/presentation/bloc/home/airing_today/airing_today_bloc.dart';
import 'package:core/presentation/bloc/home/now_playing/now_playing_bloc.dart';
import 'package:core/presentation/bloc/home/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/home/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/home_movie/playing_today_bloc.dart';
import 'package:core/presentation/bloc/popular/popular_bloc.dart';
import 'package:core/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:core/presentation/bloc/watchlist/movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/watchlist/tv_series/watchlist_tv_series_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => NowPlayingBloc(locator()),
  );
  locator.registerFactory(
    () => AiringTodayBloc(locator()),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => PlayingTodayBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => SearchBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => PopularBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => TopRatedBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => DetailBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => RecommendationBloc(locator(), locator()),
  );
  locator.registerFactory(
    () => WatchlistBloc(locator(), locator(), locator()),
  );

  // use case
  locator.registerLazySingleton<GetNowPlayingMoviesUseCase>(
      () => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton<GetPopularMoviesUseCase>(
      () => GetPopularMovies(locator()));
  locator.registerLazySingleton<GetTopRatedMoviesUseCase>(
      () => GetTopRatedMovies(locator()));
  locator.registerLazySingleton<GetMovieDetailUseCase>(
      () => GetMovieDetail(locator()));
  locator.registerLazySingleton<GetMovieRecommendationsUseCase>(
      () => GetMovieRecommendations(locator()));
  locator.registerLazySingleton<SearchMoviesUseCase>(
      () => SearchMovies(locator()));
  locator.registerLazySingleton<GetWatchListStatusUseCase>(
      () => GetWatchListStatus(locator()));
  locator.registerLazySingleton<SaveWatchlistUseCase>(
      () => SaveWatchlist(locator()));
  locator.registerLazySingleton<RemoveWatchlistUseCase>(
      () => RemoveWatchlist(locator()));
  locator.registerLazySingleton<GetWatchlistMoviesUseCase>(
      () => GetWatchlistMovies(locator()));
  locator.registerLazySingleton<GetAiringTodayTvSeriesUseCase>(
      () => GetAiringTodayTvSeries(locator()));
  locator.registerLazySingleton<GetPopularTvSeriesUseCase>(
      () => GetPopularTvSeries(locator()));
  locator.registerLazySingleton<GetTopRatedTvSeriesUseCase>(
      () => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton<GetTvSeriesDetailUseCase>(
      () => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton<GetTvSeriesRecommendationsUseCase>(
      () => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton<SearchTvSeriesUseCase>(
      () => SearchTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => IOHttpClient.client);
  locator.registerLazySingleton(() => DataConnectionChecker());
}
