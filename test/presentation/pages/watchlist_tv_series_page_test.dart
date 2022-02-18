import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/watchlist/tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistTvSeriesBloc extends MockBloc<BlocEvent, BlocState>
    implements WatchlistTvSeriesBloc {}

class WatchlistEventFake extends Fake implements BlocEvent {}

class WatchlistStateFake extends Fake implements BlocState {}

void main() {
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistEventFake());
    registerFallbackValue(WatchlistStateFake());
  });

  setUp(() {
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();
  });

  final tMovie = Movie(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvSeriesBloc>(
      create: (context) => mockWatchlistTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(StateLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(StateHasData(<Movie>[tMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display key empty when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(StateHasData(<Movie>[]));

    final keyFinder = find.byKey(Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(keyFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(StateError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
