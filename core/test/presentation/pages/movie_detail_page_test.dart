import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/bloc/detail/detail_movie/detail_bloc.dart';
import 'package:core/presentation/bloc/detail/recommendation/recommendation_bloc.dart';
import 'package:core/presentation/bloc/detail/watchlist/watchlist_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailBloc extends MockBloc<BlocEvent, BlocState>
    implements DetailBloc {}

class MockRecommendationBloc extends MockBloc<BlocEvent, BlocState>
    implements RecommendationBloc {}

class MockWatchlistBloc extends MockBloc<BlocEvent, WatchlistStatusState>
    implements WatchlistBloc {}

class DetailEventFake extends Fake implements BlocEvent {}

class DetailStateFake extends Fake implements BlocState {}

class WatchlistStateFake extends Fake implements WatchlistStatusState {}

void main() {
  late MockDetailBloc mockDetailBloc;
  late MockRecommendationBloc mockRecommendationBloc;
  late MockWatchlistBloc mockWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(DetailEventFake());
    registerFallbackValue(DetailStateFake());
    registerFallbackValue(WatchlistStateFake());
  });

  setUp(() {
    mockDetailBloc = MockDetailBloc();
    mockRecommendationBloc = MockRecommendationBloc();
    mockWatchlistBloc = MockWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailBloc>(
          create: (context) => mockDetailBloc,
        ),
        BlocProvider<RecommendationBloc>(
          create: (context) => mockRecommendationBloc,
        ),
        BlocProvider<WatchlistBloc>(
          create: (context) => mockWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state)
        .thenReturn(const StateHasData(testMovieDetail));
    when(() => mockRecommendationBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));
    when(() => mockWatchlistBloc.state)
        .thenReturn(const WatchlistStatusState(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        arguments:
            DetailScreenArguments(id: 1, category: CategoryMovie.Movies))));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state)
        .thenReturn(const StateHasData(testMovieDetail));
    when(() => mockRecommendationBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));
    when(() => mockWatchlistBloc.state)
        .thenReturn(const WatchlistStatusState(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        arguments:
            DetailScreenArguments(id: 1, category: CategoryMovie.Movies))));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state)
        .thenReturn(const StateHasData(testMovieDetail));
    when(() => mockRecommendationBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));
    when(() => mockWatchlistBloc.state)
        .thenReturn(const WatchlistStatusState(false));
    when(() => mockWatchlistBloc.watchlistMessage)
        .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        arguments:
            DetailScreenArguments(id: 1, category: CategoryMovie.Movies))));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state)
        .thenReturn(const StateHasData(testMovieDetail));
    when(() => mockRecommendationBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));
    when(() => mockWatchlistBloc.state)
        .thenReturn(const WatchlistStatusState(false));
    when(() => mockWatchlistBloc.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        arguments:
            DetailScreenArguments(id: 1, category: CategoryMovie.Movies))));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
