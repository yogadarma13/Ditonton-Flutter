import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/watchlist/movies/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMoviesUseCase])
void main() {
  late WatchlistMoviesBloc watchlistBloc;
  late MockGetWatchlistMoviesUseCase mockGetWatchlistMoviesUseCase;

  setUp(() {
    mockGetWatchlistMoviesUseCase = MockGetWatchlistMoviesUseCase();
    watchlistBloc = WatchlistMoviesBloc(mockGetWatchlistMoviesUseCase);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, StateEmpty());
  });

  group('Watchlist Movies', () {
    blocTest<WatchlistMoviesBloc, BlocState>(
      'Should emit [Loading, HasData] when data watchlist_movies movies is gotten successfully',
      build: () {
        when(mockGetWatchlistMoviesUseCase.execute(CategoryMovie.Movies.name))
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistRequest()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(
            mockGetWatchlistMoviesUseCase.execute(CategoryMovie.Movies.name));
      },
    );

    blocTest<WatchlistMoviesBloc, BlocState>(
      'Should emit [Loading, Error] when get watchlist_movies movies is unsuccessful',
      build: () {
        when(mockGetWatchlistMoviesUseCase.execute(CategoryMovie.Movies.name))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistRequest()),
      expect: () => [
        StateLoading(),
        StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(
            mockGetWatchlistMoviesUseCase.execute(CategoryMovie.Movies.name));
      },
    );
  });
}
