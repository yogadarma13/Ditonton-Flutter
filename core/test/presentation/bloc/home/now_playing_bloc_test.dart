import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/bloc/home/now_playing/now_playing_bloc.dart';
import 'package:core/presentation/bloc/home/now_playing/now_playing_event.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMoviesUseCase])
void main() {
  late NowPlayingBloc nowPlayingBloc;
  late MockGetNowPlayingMoviesUseCase mockGetNowPlayingMoviesUseCase;

  setUp(() {
    mockGetNowPlayingMoviesUseCase = MockGetNowPlayingMoviesUseCase();
    nowPlayingBloc = NowPlayingBloc(mockGetNowPlayingMoviesUseCase);
  });

  final tMovie = Movie(
    id: 2,
    overview: 'Synopsis',
    posterPath: 'poster',
    releaseDate: 'release',
    title: 'Movie1',
    voteAverage: 2,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(nowPlayingBloc.state, StateEmpty());
  });

  blocTest<NowPlayingBloc, BlocState>(
    'Should emit [Loading, HasData] when data now playing movies is gotten successfully',
    build: () {
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnNowPlayingRequest()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      StateLoading(),
      StateHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMoviesUseCase.execute());
    },
  );

  blocTest<NowPlayingBloc, BlocState>(
    'Should emit [Loading, Error] when get now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnNowPlayingRequest()),
    expect: () => [
      StateLoading(),
      const StateError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMoviesUseCase.execute());
    },
  );
}
