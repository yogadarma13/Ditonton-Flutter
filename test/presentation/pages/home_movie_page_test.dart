import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home_movie/playing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPlayingTodayBloc extends MockBloc<BlocEvent, BlocState>
    implements PlayingTodayBloc {}

class MockPopularBloc extends MockBloc<BlocEvent, BlocState>
    implements PopularBloc {}

class MockTopRatedBloc extends MockBloc<BlocEvent, BlocState>
    implements TopRatedBloc {}

class HomeMovieEventFake extends Fake implements BlocEvent {}

class HomeMovieStateFake extends Fake implements BlocState {}

void main() {
  late MockPlayingTodayBloc mockPlayingTodayBloc;
  late MockPopularBloc mockPopularBloc;
  late MockTopRatedBloc mockTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(HomeMovieEventFake());
    registerFallbackValue(HomeMovieStateFake());
  });

  setUp(() {
    mockPlayingTodayBloc = MockPlayingTodayBloc();
    mockPopularBloc = MockPopularBloc();
    mockTopRatedBloc = MockTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayingTodayBloc>(
          create: (context) => mockPlayingTodayBloc,
        ),
        BlocProvider<PopularBloc>(
          create: (context) => mockPopularBloc,
        ),
        BlocProvider<TopRatedBloc>(
          create: (context) => mockTopRatedBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPlayingTodayBloc.state).thenReturn(StateLoading());
    when(() => mockPopularBloc.state).thenReturn(StateLoading());
    when(() => mockTopRatedBloc.state).thenReturn(StateLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(
        _makeTestableWidget(HomeMoviePage(category: CategoryMovie.Movies)));
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPlayingTodayBloc.state).thenReturn(StateHasData(<Movie>[]));
    when(() => mockPopularBloc.state).thenReturn(StateHasData(<Movie>[]));
    when(() => mockTopRatedBloc.state).thenReturn(StateHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
        _makeTestableWidget(HomeMoviePage(category: CategoryMovie.Movies)));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPlayingTodayBloc.state).thenReturn(StateError('Failed'));
    when(() => mockPopularBloc.state).thenReturn(StateError('Failed'));
    when(() => mockTopRatedBloc.state).thenReturn(StateError('Failed'));

    await tester.pumpWidget(
        _makeTestableWidget(HomeMoviePage(category: CategoryMovie.Movies)));

    expect(find.text('Failed'), findsWidgets);
  });
}
