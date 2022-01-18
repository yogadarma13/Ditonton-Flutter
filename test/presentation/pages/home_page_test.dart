import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([HomeNotifier])
void main() {
  late MockHomeNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockHomeNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<HomeNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
    when(mockNotifier.airingTodayState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.nowPlayingMovies).thenReturn(<Movie>[]);
    when(mockNotifier.airingTodayState).thenReturn(RequestState.Loaded);
    when(mockNotifier.airingTodayTvSeries).thenReturn(<Movie>[]);
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularMovies).thenReturn(<Movie>[]);
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTvSeries).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Failed');
    when(mockNotifier.airingTodayState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Failed');
    when(mockNotifier.popularMoviesState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Failed');
    when(mockNotifier.popularTvSeriesState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Failed');

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    expect(find.text('Failed'), findsWidgets);
  });
}
