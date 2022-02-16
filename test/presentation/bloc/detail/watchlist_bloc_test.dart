import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/detail/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/detail/watchlist/watchlist_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
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

  final tId = 1;
  final tvId = 13;

  group('Watchlist', () {
    blocTest<WatchlistBloc, WatchlistStatusState>(
      'Should emit WatchlistStatusState true when watchlist status is true',
      build: () {
        when(mockGetWatchListStatusUseCase.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistStatusRequest(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistStatusState(true),
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
      act: (bloc) => bloc.add(OnWatchlistStatusRequest(tvId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistStatusState(false),
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
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchListStatusUseCase.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(
          OnSaveWatchlistRequest(testMovieDetail, CategoryMovie.Movies.name)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistStatusState(true),
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
            .thenAnswer((_) async => Right('Removed'));
        when(mockGetWatchListStatusUseCase.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlistRequest(testMovieDetail)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistStatusState(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistUseCase.execute(testMovieDetail));
      },
    );
  });
}
