import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/home/airing_today/airing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/home/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/home/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/home/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/movies/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/tv_repository_impl.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/search_tv_series.dart';

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

  // provider
  locator.registerFactory(
    () => HomeNotifier(
        getNowPlayingMovies: locator(),
        getAiringTodayTvSeries: locator(),
        getPopularMovies: locator(),
        getPopularTvSeries: locator()),
  );
  locator.registerFactory(
    () => MovieListNotifier(
        getNowPlayingMovies: locator(),
        getAiringTodayTvSeries: locator(),
        getPopularMovies: locator(),
        getPopularTvSeries: locator(),
        getTopRatedMovies: locator(),
        getTopRatedTvSeries: locator()),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(locator(), locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
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
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
