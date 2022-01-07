import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase, GetPopularTvSeriesUseCase])
void main() {
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late MockGetPopularTvSeriesUseCase mockGetPopularTvSeriesUseCase;
  late PopularMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    mockGetPopularTvSeriesUseCase = MockGetPopularTvSeriesUseCase();
    notifier = PopularMoviesNotifier(mockGetPopularMoviesUseCase, mockGetPopularTvSeriesUseCase)
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

  group('Popular Movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      notifier.fetchPopularMovies();
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await notifier.fetchPopularMovies();
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.movies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchPopularMovies();
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      notifier.fetchPopularMovies(CategoryMovie.TvSeries);
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });
  });
}
