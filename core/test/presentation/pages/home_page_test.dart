import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/bloc/home/airing_today/airing_today_bloc.dart';
import 'package:core/presentation/bloc/home/now_playing/now_playing_bloc.dart';
import 'package:core/presentation/bloc/home/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/home/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNowPlayingBloc extends MockBloc<BlocEvent, BlocState>
    implements NowPlayingBloc {}

class MockAiringTodayBloc extends MockBloc<BlocEvent, BlocState>
    implements AiringTodayBloc {}

class MockPopularMoviesBloc extends MockBloc<BlocEvent, BlocState>
    implements PopularMoviesBloc {}

class MockPopularTvSeriesBloc extends MockBloc<BlocEvent, BlocState>
    implements PopularTvSeriesBloc {}

class HomeEventFake extends Fake implements BlocEvent {}

class HomeStateFake extends Fake implements BlocState {}

void main() {
  late MockNowPlayingBloc mockNowPlayingBloc;
  late MockAiringTodayBloc mockAiringTodayBloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(HomeEventFake());
    registerFallbackValue(HomeStateFake());
  });

  setUp(() {
    mockNowPlayingBloc = MockNowPlayingBloc();
    mockAiringTodayBloc = MockAiringTodayBloc();
    mockPopularMoviesBloc = MockPopularMoviesBloc();
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingBloc>(
          create: (context) => mockNowPlayingBloc,
        ),
        BlocProvider<AiringTodayBloc>(
          create: (context) => mockAiringTodayBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
        BlocProvider<PopularTvSeriesBloc>(
          create: (context) => mockPopularTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingBloc.state).thenReturn(StateLoading());
    when(() => mockAiringTodayBloc.state).thenReturn(StateLoading());
    when(() => mockPopularMoviesBloc.state).thenReturn(StateLoading());
    when(() => mockPopularTvSeriesBloc.state).thenReturn(StateLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));
    when(() => mockAiringTodayBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));
    when(() => mockPopularMoviesBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));
    when(() => mockPopularTvSeriesBloc.state)
        .thenReturn(const StateHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingBloc.state).thenReturn(const StateError('Failed'));
    when(() => mockAiringTodayBloc.state)
        .thenReturn(const StateError('Failed'));
    when(() => mockPopularMoviesBloc.state)
        .thenReturn(const StateError('Failed'));
    when(() => mockPopularTvSeriesBloc.state)
        .thenReturn(const StateError('Failed'));

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    expect(find.text('Failed'), findsWidgets);
  });
}
