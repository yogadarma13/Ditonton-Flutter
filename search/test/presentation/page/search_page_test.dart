import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/page/search_page.dart';

class MockSearchBloc extends MockBloc<BlocEvent, BlocState>
    implements SearchBloc {}

class SearchEventFake extends Fake implements BlocEvent {}

class SearchStateFake extends Fake implements BlocState {}

void main() {
  late MockSearchBloc mockSearchBloc;

  setUpAll(() {
    registerFallbackValue(SearchEventFake());
    registerFallbackValue(SearchStateFake());
  });

  setUp(() {
    mockSearchBloc = MockSearchBloc();
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
    return BlocProvider<SearchBloc>(
      create: (context) => mockSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state).thenReturn(StateLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(
        _makeTestableWidget(const SearchPage(CategoryMovie.Movies)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state).thenReturn(StateHasData(<Movie>[tMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
        _makeTestableWidget(const SearchPage(CategoryMovie.Movies)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display key empty when data is empty',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state).thenReturn(const StateHasData(<Movie>[]));

    final keyFinder = find.byKey(const Key('empty_message'));

    await tester.pumpWidget(
        _makeTestableWidget(const SearchPage(CategoryMovie.Movies)));

    expect(keyFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state)
        .thenReturn(const StateError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(
        _makeTestableWidget(const SearchPage(CategoryMovie.Movies)));

    expect(textFinder, findsOneWidget);
  });
}
