import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedBloc extends MockBloc<BlocEvent, BlocState>
    implements TopRatedBloc {}

class TopRatedEventFake extends Fake implements BlocEvent {}

class TopRatedStateFake extends Fake implements BlocState {}

void main() {
  late MockTopRatedBloc mockTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedEventFake());
    registerFallbackValue(TopRatedStateFake());
  });

  setUp(() {
    mockTopRatedBloc = MockTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedBloc>(
      create: (context) => mockTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state).thenReturn(StateLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(
        TopRatedMoviesPage(category: CategoryMovie.Movies)));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state).thenReturn(StateHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(
        TopRatedMoviesPage(category: CategoryMovie.Movies)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state).thenReturn(StateError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(
        TopRatedMoviesPage(category: CategoryMovie.Movies)));

    expect(textFinder, findsOneWidget);
  });
}
