import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/bloc/watchlist/movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
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
      act: (bloc) => bloc.add(const OnWatchlistRequest()),
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
      act: (bloc) => bloc.add(const OnWatchlistRequest()),
      expect: () => [
        StateLoading(),
        const StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(
            mockGetWatchlistMoviesUseCase.execute(CategoryMovie.Movies.name));
      },
    );
  });
}
