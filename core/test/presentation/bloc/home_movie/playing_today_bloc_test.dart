import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_airing_today_tv_series.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/bloc/home_movie/playing_today_bloc.dart';
import 'package:core/presentation/bloc/home_movie/playing_today_event.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'playing_today_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMoviesUseCase, GetAiringTodayTvSeriesUseCase])
void main() {
  late PlayingTodayBloc playingTodayBloc;
  late MockGetNowPlayingMoviesUseCase mockGetNowPlayingMoviesUseCase;
  late MockGetAiringTodayTvSeriesUseCase mockGetAiringTodayTvSeriesUseCase;

  setUp(() {
    mockGetNowPlayingMoviesUseCase = MockGetNowPlayingMoviesUseCase();
    mockGetAiringTodayTvSeriesUseCase = MockGetAiringTodayTvSeriesUseCase();
    playingTodayBloc = PlayingTodayBloc(
        mockGetNowPlayingMoviesUseCase, mockGetAiringTodayTvSeriesUseCase);
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
    expect(playingTodayBloc.state, StateEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<PlayingTodayBloc, BlocState>(
      'Should emit [Loading, HasData] when data now playing movies is gotten successfully',
      build: () {
        when(mockGetNowPlayingMoviesUseCase.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return playingTodayBloc;
      },
      act: (bloc) =>
          bloc.add(const OnPlayingTodayRequest(CategoryMovie.Movies)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMoviesUseCase.execute());
      },
    );

    blocTest<PlayingTodayBloc, BlocState>(
      'Should emit [Loading, Error] when get now playing movies is unsuccessful',
      build: () {
        when(mockGetNowPlayingMoviesUseCase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return playingTodayBloc;
      },
      act: (bloc) =>
          bloc.add(const OnPlayingTodayRequest(CategoryMovie.Movies)),
      expect: () => [
        StateLoading(),
        const StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMoviesUseCase.execute());
      },
    );
  });

  group('Airing Today TV Series', () {
    blocTest<PlayingTodayBloc, BlocState>(
      'Should emit [Loading, HasData] when data airing today tv series is gotten successfully',
      build: () {
        when(mockGetAiringTodayTvSeriesUseCase.execute())
            .thenAnswer((_) async => Right(tMovieList2));
        return playingTodayBloc;
      },
      act: (bloc) =>
          bloc.add(const OnPlayingTodayRequest(CategoryMovie.TvSeries)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(tMovieList2),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTvSeriesUseCase.execute());
      },
    );

    blocTest<PlayingTodayBloc, BlocState>(
      'Should emit [Loading, Error] when get airing today tv series is unsuccessful',
      build: () {
        when(mockGetAiringTodayTvSeriesUseCase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return playingTodayBloc;
      },
      act: (bloc) =>
          bloc.add(const OnPlayingTodayRequest(CategoryMovie.TvSeries)),
      expect: () => [
        StateLoading(),
        const StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTvSeriesUseCase.execute());
      },
    );
  });
}
