import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedMoviesUseCase, GetTopRatedTvSeriesUseCase])
void main() {
  late MockGetTopRatedMoviesUseCase mockGetTopRatedMoviesUseCase;
  late MockGetTopRatedTvSeriesUseCase mockGetTopRatedTvSeriesUseCase;
  late TopRatedMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedMoviesUseCase = MockGetTopRatedMoviesUseCase();
    mockGetTopRatedTvSeriesUseCase = MockGetTopRatedTvSeriesUseCase();
    notifier = TopRatedMoviesNotifier(
        getTopRatedMovies: mockGetTopRatedMoviesUseCase,
        getTopRatedTvSeries: mockGetTopRatedTvSeriesUseCase)
      ..addListener(() {
        listenerCallCount++;
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

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      notifier.fetchTopRatedMovies(CategoryMovie.Movies);
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await notifier.fetchTopRatedMovies(CategoryMovie.Movies);
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.movies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedMoviesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchTopRatedMovies(CategoryMovie.Movies);
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      notifier.fetchTopRatedMovies(CategoryMovie.TvSeries);
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      await notifier.fetchTopRatedMovies(CategoryMovie.TvSeries);
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.movies, tMovieList2);
      expect(listenerCallCount, 2);
    });
  });
}
