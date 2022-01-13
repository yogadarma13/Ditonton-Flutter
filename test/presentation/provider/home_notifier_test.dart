import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMoviesUseCase,
  GetAiringTodayTvSeriesUseCase,
  GetPopularMoviesUseCase,
])
void main() {
  late HomeNotifier provider;
  late MockGetNowPlayingMoviesUseCase mockGetNowPlayingMoviesUseCase;
  late MockGetAiringTodayTvSeriesUseCase mockGetAiringTodayTvSeriesUseCase;
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMoviesUseCase = MockGetNowPlayingMoviesUseCase();
    mockGetAiringTodayTvSeriesUseCase = MockGetAiringTodayTvSeriesUseCase();
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    provider = HomeNotifier(
      getNowPlayingMovies: mockGetNowPlayingMoviesUseCase,
      getAiringTodayTvSeries: mockGetAiringTodayTvSeriesUseCase,
      getPopularMovies: mockGetPopularMoviesUseCase,
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
      provider.fetchNowPlayingMovies();
      // assert
      verify(mockGetNowPlayingMoviesUseCase.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchNowPlayingMovies();
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
      await provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('airing today tv series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      provider.fetchAiringTodayTvSeries();
      // assert
      verify(mockGetAiringTodayTvSeriesUseCase.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      await provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvSeries, tMovieList2);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('initialState should be Empty', () {
      expect(provider.popularMoviesState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchPopularMovies();
      // assert
      verify(mockGetPopularMoviesUseCase.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchPopularMovies();
      // assert
      expect(provider.popularMoviesState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchPopularMovies();
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
      await provider.fetchPopularMovies();
      // assert
      expect(provider.popularMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
