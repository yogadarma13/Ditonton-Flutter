import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMoviesUseCase,
  GetPopularMoviesUseCase,
  GetTopRatedMoviesUseCase,
  GetAiringTodayTvSeriesUseCase,
  GetPopularTvSeriesUseCase,
  GetTopRatedTvSeriesUseCase
])
void main() {
  late MovieListNotifier provider;
  late MockGetNowPlayingMoviesUseCase mockGetNowPlayingMoviesUseCase;
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late MockGetTopRatedMoviesUseCase mockGetTopRatedMoviesUseCase;
  late MockGetAiringTodayTvSeriesUseCase mockGetAiringTodayTvSeriesUseCase;
  late MockGetPopularTvSeriesUseCase mockGetPopularTvSeriesUseCase;
  late MockGetTopRatedTvSeriesUseCase mockGetTopRatedTvSeriesUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMoviesUseCase = MockGetNowPlayingMoviesUseCase();
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    mockGetTopRatedMoviesUseCase = MockGetTopRatedMoviesUseCase();
    mockGetAiringTodayTvSeriesUseCase = MockGetAiringTodayTvSeriesUseCase();
    mockGetPopularTvSeriesUseCase = MockGetPopularTvSeriesUseCase();
    mockGetTopRatedTvSeriesUseCase = MockGetTopRatedTvSeriesUseCase();
    provider = MovieListNotifier(
      getNowPlayingMovies: mockGetNowPlayingMoviesUseCase,
      getAiringTodayTvSeries: mockGetAiringTodayTvSeriesUseCase,
      getPopularMovies: mockGetPopularMoviesUseCase,
      getTopRatedMovies: mockGetTopRatedMoviesUseCase,
      getPopularTvSeries: mockGetPopularTvSeriesUseCase,
      getTopRatedTvSeries: mockGetTopRatedTvSeriesUseCase,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tMovie = Movie(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
  );

  final tMovie2 = Movie(
    id: 2,
    overview: 'Synopsis',
    posterPath: 'poster',
    releaseDate: 'release',
    title: 'Movie1',
    voteAverage: 2,
  );

  final tMovieList = <Movie>[tMovie];
  final tMovieList2 = <Movie>[tMovie2];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies(CategoryMovie.Movies);
      // assert
      verify(mockGetNowPlayingMoviesUseCase.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies(CategoryMovie.Movies);
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchNowPlayingMovies(CategoryMovie.Movies);
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingMovies(CategoryMovie.Movies);
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchPopularMovies(CategoryMovie.Movies);
      // assert
      expect(provider.popularMoviesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchPopularMovies(CategoryMovie.Movies);
      // assert
      expect(provider.popularMoviesState, RequestState.Loaded);
      expect(provider.popularMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularMovies(CategoryMovie.Movies);
      // assert
      expect(provider.popularMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchTopRatedMovies(CategoryMovie.Movies);
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchTopRatedMovies(CategoryMovie.Movies);
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loaded);
      expect(provider.topRatedMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedMoviesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedMovies(CategoryMovie.Movies);
      // assert
      expect(provider.topRatedMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('airing today tv series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      provider.fetchNowPlayingMovies(CategoryMovie.TvSeries);
      // assert
      verify(mockGetAiringTodayTvSeriesUseCase.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      provider.fetchNowPlayingMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      await provider.fetchNowPlayingMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingMovies, tMovieList2);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('initialState should be Empty', () {
      expect(provider.popularMoviesState, equals(RequestState.Empty));
    });

    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      provider.fetchPopularMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.popularMoviesState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      await provider.fetchPopularMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.popularMoviesState, RequestState.Loaded);
      expect(provider.popularMovies, tMovieList2);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.popularMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('initialState should be Empty', () {
      expect(provider.topRatedMoviesState, equals(RequestState.Empty));
    });

    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      provider.fetchTopRatedMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      await provider.fetchTopRatedMovies(CategoryMovie.TvSeries);
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loaded);
      expect(provider.topRatedMovies, tMovieList2);
      expect(listenerCallCount, 2);
    });
  });
}
