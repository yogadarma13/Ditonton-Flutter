import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/domain/usecases/get_watchlist_status.dart';
import 'package:detail/domain/usecases/remove_watchlist.dart';
import 'package:detail/domain/usecases/save_watchlist.dart';
import 'package:detail/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:detail/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchListStatusUseCase, SaveWatchlistUseCase, RemoveWatchlistUseCase])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchListStatusUseCase mockGetWatchListStatusUseCase;
  late MockSaveWatchlistUseCase mockSaveWatchlistUseCase;
  late MockRemoveWatchlistUseCase mockRemoveWatchlistUseCase;

  setUp(() {
    mockGetWatchListStatusUseCase = MockGetWatchListStatusUseCase();
    mockSaveWatchlistUseCase = MockSaveWatchlistUseCase();
    mockRemoveWatchlistUseCase = MockRemoveWatchlistUseCase();
    watchlistBloc = WatchlistBloc(mockGetWatchListStatusUseCase,
        mockSaveWatchlistUseCase, mockRemoveWatchlistUseCase);
  });

  const tId = 1;
  const tvId = 13;

  group('Watchlist', () {
    blocTest<WatchlistBloc, WatchlistStatusState>(
      'Should emit WatchlistStatusState true when watchlist status is true',
      build: () {
        when(mockGetWatchListStatusUseCase.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(const OnWatchlistStatusRequest(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const WatchlistStatusState(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatusUseCase.execute(tId));
      },
    );

    blocTest<WatchlistBloc, WatchlistStatusState>(
      'Should emit WatchlistStatusState false when watchlist status is false',
      build: () {
        when(mockGetWatchListStatusUseCase.execute(tvId))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(const OnWatchlistStatusRequest(tvId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const WatchlistStatusState(false),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatusUseCase.execute(tvId));
      },
    );

    blocTest<WatchlistBloc, WatchlistStatusState>(
      'Should emit WatchlistStatusState true when function save watchlist called',
      build: () {
        when(mockSaveWatchlistUseCase.execute(
                testMovieDetail, CategoryMovie.Movies.name))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchListStatusUseCase.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(
          OnSaveWatchlistRequest(testMovieDetail, CategoryMovie.Movies.name)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const WatchlistStatusState(true),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistUseCase.execute(
            testMovieDetail, CategoryMovie.Movies.name));
      },
    );

    blocTest<WatchlistBloc, WatchlistStatusState>(
      'Should emit WatchlistStatusState false when function remove watchlist called',
      build: () {
        when(mockRemoveWatchlistUseCase.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchListStatusUseCase.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(const OnRemoveWatchlistRequest(testMovieDetail)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const WatchlistStatusState(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistUseCase.execute(testMovieDetail));
      },
    );
  });
}
