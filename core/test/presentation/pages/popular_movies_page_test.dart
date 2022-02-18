import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/bloc/popular/popular_bloc.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularBloc extends MockBloc<BlocEvent, BlocState>
    implements PopularBloc {}

class PopularEventFake extends Fake implements BlocEvent {}

class PopularStateFake extends Fake implements BlocState {}

void main() {
  late MockPopularBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(PopularEventFake());
    registerFallbackValue(PopularStateFake());
  });

  setUp(() {
    mockBloc = MockPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularBloc>(
      create: (context) => mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(StateLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(
        const PopularMoviesPage(category: CategoryMovie.Movies)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const StateHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(
        const PopularMoviesPage(category: CategoryMovie.Movies)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const StateError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(
        const PopularMoviesPage(category: CategoryMovie.Movies)));

    expect(textFinder, findsOneWidget);
  });
}
