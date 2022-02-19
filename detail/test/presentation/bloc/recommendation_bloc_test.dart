import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/domain/usecases/get_movie_recommendations.dart';
import 'package:detail/domain/usecases/get_tv_series_recommendations.dart';
import 'package:detail/presentation/bloc/recommendation/recommendation_bloc.dart';
import 'package:detail/presentation/bloc/recommendation/recommendation_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks(
    [GetMovieRecommendationsUseCase, GetTvSeriesRecommendationsUseCase])
void main() {
  late RecommendationBloc recommendationBloc;
  late MockGetMovieRecommendationsUseCase mockGetMovieRecommendationsUseCase;
  late MockGetTvSeriesRecommendationsUseCase
      mockGetTvSeriesRecommendationsUseCase;

  setUp(() {
    mockGetMovieRecommendationsUseCase = MockGetMovieRecommendationsUseCase();
    mockGetTvSeriesRecommendationsUseCase =
        MockGetTvSeriesRecommendationsUseCase();
    recommendationBloc = RecommendationBloc(mockGetMovieRecommendationsUseCase,
        mockGetTvSeriesRecommendationsUseCase);
  });

  const tId = 1;
  const tvId = 13;

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

  test('initial state should be empty', () {
    expect(recommendationBloc.state, StateEmpty());
  });

  group('Recommendation Movies', () {
    blocTest<RecommendationBloc, BlocState>(
      'Should emit [Loading, HasData] when data recommendation movies is gotten successfully',
      build: () {
        when(mockGetMovieRecommendationsUseCase.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return recommendationBloc;
      },
      act: (bloc) =>
          bloc.add(const OnRecommendationRequest(CategoryMovie.Movies, tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendationsUseCase.execute(tId));
      },
    );

    blocTest<RecommendationBloc, BlocState>(
      'Should emit [Loading, Error] when get recommendation movies is unsuccessful',
      build: () {
        when(mockGetMovieRecommendationsUseCase.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationBloc;
      },
      act: (bloc) =>
          bloc.add(const OnRecommendationRequest(CategoryMovie.Movies, tId)),
      expect: () => [
        StateLoading(),
        const StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendationsUseCase.execute(tId));
      },
    );
  });

  group('Recommendation TV Series', () {
    blocTest<RecommendationBloc, BlocState>(
      'Should emit [Loading, HasData] when data recommendation tv series is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecommendationsUseCase.execute(tvId))
            .thenAnswer((_) async => Right(tMovies2));
        return recommendationBloc;
      },
      act: (bloc) =>
          bloc.add(const OnRecommendationRequest(CategoryMovie.TvSeries, tvId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(tMovies2),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendationsUseCase.execute(tvId));
      },
    );

    blocTest<RecommendationBloc, BlocState>(
      'Should emit [Loading, Error] when get recommendation tv series is unsuccessful',
      build: () {
        when(mockGetTvSeriesRecommendationsUseCase.execute(tvId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationBloc;
      },
      act: (bloc) =>
          bloc.add(const OnRecommendationRequest(CategoryMovie.TvSeries, tvId)),
      expect: () => [
        StateLoading(),
        const StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendationsUseCase.execute(tvId));
      },
    );
  });
}
