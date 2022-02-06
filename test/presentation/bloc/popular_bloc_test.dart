import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase, GetPopularTvSeriesUseCase])
void main() {
  late PopularBloc popularBloc;
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late MockGetPopularTvSeriesUseCase mockGetPopularTvSeriesUseCase;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    mockGetPopularTvSeriesUseCase = MockGetPopularTvSeriesUseCase();
    popularBloc =
        PopularBloc(mockGetPopularMoviesUseCase, mockGetPopularTvSeriesUseCase);
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

  test('initial state should be empty', () {
    expect(popularBloc.state, PopularEmpty());
  });

  group('Popular Movies', () {
    blocTest<PopularBloc, PopularState>(
      'Should emit [Loading, HasData] when data popular movies is gotten successfully',
      build: () {
        when(mockGetPopularMoviesUseCase.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnPopularRequest(CategoryMovie.Movies)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularLoading(),
        PopularHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMoviesUseCase.execute());
      },
    );

    blocTest<PopularBloc, PopularState>(
      'Should emit [Loading, Error] when get popular movies is unsuccessful',
      build: () {
        when(mockGetPopularMoviesUseCase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnPopularRequest(CategoryMovie.Movies)),
      expect: () => [
        PopularLoading(),
        PopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMoviesUseCase.execute());
      },
    );
  });

  group('Popular TV Series', () {
    blocTest<PopularBloc, PopularState>(
      'Should emit [Loading, HasData] when data popular tv series is gotten successfully',
      build: () {
        when(mockGetPopularTvSeriesUseCase.execute())
            .thenAnswer((_) async => Right(tMovieList2));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnPopularRequest(CategoryMovie.TvSeries)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularLoading(),
        PopularHasData(tMovieList2),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeriesUseCase.execute());
      },
    );

    blocTest<PopularBloc, PopularState>(
      'Should emit [Loading, Error] when get popular tv series is unsuccessful',
      build: () {
        when(mockGetPopularTvSeriesUseCase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (bloc) => bloc.add(OnPopularRequest(CategoryMovie.TvSeries)),
      expect: () => [
        PopularLoading(),
        PopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeriesUseCase.execute());
      },
    );
  });
}
