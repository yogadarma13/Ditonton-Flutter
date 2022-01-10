import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetailUseCase,
  GetTvSeriesDetailUseCase,
  GetMovieRecommendationsUseCase,
  GetTvSeriesRecommendationsUseCase,
  GetWatchListStatusUseCase,
  SaveWatchlistUseCase,
  RemoveWatchlistUseCase,
])
void main() {
  late MovieDetailNotifier provider;
  late MockGetMovieDetailUseCase mockGetMovieDetailUseCase;
  late MockGetTvSeriesDetailUseCase mockGetTvSeriesDetailUseCase;
  late MockGetMovieRecommendationsUseCase mockGetMovieRecommendationsUseCase;
  late MockGetTvSeriesRecommendationsUseCase
      mockGetTvSeriesRecommendationsUseCase;
  late MockGetWatchListStatusUseCase mockGetWatchlistStatusUseCase;
  late MockSaveWatchlistUseCase mockSaveWatchlistUseCase;
  late MockRemoveWatchlistUseCase mockRemoveWatchlistUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetailUseCase = MockGetMovieDetailUseCase();
    mockGetTvSeriesDetailUseCase = MockGetTvSeriesDetailUseCase();
    mockGetMovieRecommendationsUseCase = MockGetMovieRecommendationsUseCase();
    mockGetTvSeriesRecommendationsUseCase =
        MockGetTvSeriesRecommendationsUseCase();
    mockGetWatchlistStatusUseCase = MockGetWatchListStatusUseCase();
    mockSaveWatchlistUseCase = MockSaveWatchlistUseCase();
    mockRemoveWatchlistUseCase = MockRemoveWatchlistUseCase();
    provider = MovieDetailNotifier(
      getMovieDetail: mockGetMovieDetailUseCase,
      getTvSeriesDetail: mockGetTvSeriesDetailUseCase,
      getMovieRecommendations: mockGetMovieRecommendationsUseCase,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendationsUseCase,
      getWatchListStatus: mockGetWatchlistStatusUseCase,
      saveWatchlist: mockSaveWatchlistUseCase,
      removeWatchlist: mockRemoveWatchlistUseCase,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final tvId = 13;

  final tMovie = Movie(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
  );

  final tMovie2 = Movie(
      id: 1,
      overview: "Overview TV",
      posterPath: "/tv-series.jpg",
      releaseDate: "2022-01-01",
      title: "TV Series Dicoding",
      voteAverage: 98.4);

  final tMovies = <Movie>[tMovie];
  final tMovies2 = <Movie>[tMovie2];

  void _arrangeUsecase() {
    when(mockGetMovieDetailUseCase.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetTvSeriesDetailUseCase.execute(tvId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetMovieRecommendationsUseCase.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
    when(mockGetTvSeriesRecommendationsUseCase.execute(tvId))
        .thenAnswer((_) async => Right(tMovies2));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      verify(mockGetMovieDetailUseCase.execute(tId));
      verify(mockGetMovieRecommendationsUseCase.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      expect(provider.movieState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movie, testMovieDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movieRecommendations, tMovies);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      verify(mockGetMovieRecommendationsUseCase.execute(tId));
      expect(provider.movieRecommendations, tMovies);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.movieRecommendations, tMovies);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetMovieDetailUseCase.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendationsUseCase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusUseCase.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistUseCase.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusUseCase.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testMovieDetail);
      // assert
      verify(mockSaveWatchlistUseCase.execute(testMovieDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistUseCase.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatusUseCase.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testMovieDetail);
      // assert
      verify(mockRemoveWatchlistUseCase.execute(testMovieDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistUseCase.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusUseCase.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testMovieDetail);
      // assert
      verify(mockGetWatchlistStatusUseCase.execute(testMovieDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistUseCase.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatusUseCase.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testMovieDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetMovieDetailUseCase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendationsUseCase.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      // act
      await provider.fetchMovieDetail(CategoryMovie.Movies, tId);
      // assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Get TV Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.TvSeries, tvId);
      // assert
      verify(mockGetTvSeriesDetailUseCase.execute(tvId));
      verify(mockGetTvSeriesRecommendationsUseCase.execute(tvId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchMovieDetail(CategoryMovie.TvSeries, tvId);
      // assert
      expect(provider.movieState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.TvSeries, tvId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movie, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.TvSeries, tvId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movieRecommendations, tMovies2);
    });
  });

  group('Get TV Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.TvSeries, tvId);
      // assert
      verify(mockGetTvSeriesRecommendationsUseCase.execute(tvId));
      expect(provider.movieRecommendations, tMovies2);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(CategoryMovie.TvSeries, tvId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.movieRecommendations, tMovies2);
    });
  });
}
