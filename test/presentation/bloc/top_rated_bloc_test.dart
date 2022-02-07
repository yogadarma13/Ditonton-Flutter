import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMoviesUseCase, GetTopRatedTvSeriesUseCase])
void main() {
  late TopRatedBloc topRatedBloc;
  late MockGetTopRatedMoviesUseCase mockGetTopRatedMoviesUseCase;
  late MockGetTopRatedTvSeriesUseCase mockGetTopRatedTvSeriesUseCase;

  setUp(() {
    mockGetTopRatedMoviesUseCase = MockGetTopRatedMoviesUseCase();
    mockGetTopRatedTvSeriesUseCase = MockGetTopRatedTvSeriesUseCase();
    topRatedBloc = TopRatedBloc(
        mockGetTopRatedMoviesUseCase, mockGetTopRatedTvSeriesUseCase);
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
    expect(topRatedBloc.state, StateEmpty());
  });

  group('Top Rated Movies', () {
    blocTest<TopRatedBloc, BlocState>(
      'Should emit [Loading, HasData] when data top rated movies is gotten successfully',
      build: () {
        when(mockGetTopRatedMoviesUseCase.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedRequest(CategoryMovie.Movies)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMoviesUseCase.execute());
      },
    );

    blocTest<TopRatedBloc, BlocState>(
      'Should emit [Loading, Error] when get top rated movies is unsuccessful',
      build: () {
        when(mockGetTopRatedMoviesUseCase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedRequest(CategoryMovie.Movies)),
      expect: () => [
        StateLoading(),
        StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMoviesUseCase.execute());
      },
    );
  });

  group('Top Rated TV Series', () {
    blocTest<TopRatedBloc, BlocState>(
      'Should emit [Loading, HasData] when data top rated tv series is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeriesUseCase.execute())
            .thenAnswer((_) async => Right(tMovieList2));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedRequest(CategoryMovie.TvSeries)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(tMovieList2),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeriesUseCase.execute());
      },
    );

    blocTest<TopRatedBloc, BlocState>(
      'Should emit [Loading, Error] when get top rated tv series is unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeriesUseCase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedRequest(CategoryMovie.TvSeries)),
      expect: () => [
        StateLoading(),
        StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeriesUseCase.execute());
      },
    );
  });
}
