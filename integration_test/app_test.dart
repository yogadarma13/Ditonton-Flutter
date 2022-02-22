import 'package:about/about.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:detail/detail.dart';
import 'package:ditonton/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_movie/home_movie.dart';
import 'package:integration_test/integration_test.dart';
import 'package:popular/popular.dart';
import 'package:search/presentation/page/search_page.dart';
import 'package:top_rated/presentation/pages/top_rated_movies_page.dart';
import 'package:watchlist/presentation/page/watchlist_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('open movies page and search movie', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final movieButton = find.text('Movies');
    expect(movieButton, findsOneWidget);
    await tester.tap(movieButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsWidgets);
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    final searchButton = find.byKey(Key('search'));
    expect(searchButton, findsOneWidget);
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.text('Search Movies'), findsOneWidget);
    expect(find.byKey(Key('empty_image')), findsOneWidget);
    expect(find.text('No Data'), findsOneWidget);

    final searchTextField = find.byType(TextField);
    expect(searchTextField, findsOneWidget);
    await tester.enterText(searchTextField, 'spiderman');
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(find.byType(ListView), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('open TV Series page and search tv series', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final movieButton = find.text('TV Series');
    expect(movieButton, findsOneWidget);
    await tester.tap(movieButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsWidgets);
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    final searchButton = find.byKey(Key('search'));
    expect(searchButton, findsOneWidget);
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.text('Search TV Series'), findsOneWidget);
    expect(find.byKey(Key('empty_image')), findsOneWidget);
    expect(find.text('No Data'), findsOneWidget);

    final searchTextField = find.byType(TextField);
    expect(searchTextField, findsOneWidget);
    await tester.enterText(searchTextField, 'victoria');
    await tester.pumpAndSettle(Duration(seconds: 2));
    expect(find.byType(ListView), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('open popular movies page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final movieButton = find.text('Movies');
    expect(movieButton, findsOneWidget);
    await tester.tap(movieButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsWidgets);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    final seeMoreText = find.text('See More');
    expect(seeMoreText, findsWidgets);
    await tester.tap(seeMoreText.first);
    await tester.pumpAndSettle();

    expect(find.byType(PopularMoviesPage), findsOneWidget);
    expect(find.text('Popular Movies'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('open popular tv series page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final movieButton = find.text('TV Series');
    expect(movieButton, findsOneWidget);
    await tester.tap(movieButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsWidgets);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    final seeMoreText = find.text('See More');
    expect(seeMoreText, findsWidgets);
    await tester.tap(seeMoreText.first);
    await tester.pumpAndSettle();

    expect(find.byType(PopularMoviesPage), findsOneWidget);
    expect(find.text('Popular TV Series'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('open top rated movies page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final movieButton = find.text('Movies');
    expect(movieButton, findsOneWidget);
    await tester.tap(movieButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsWidgets);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    final seeMoreText = find.text('See More');
    expect(seeMoreText, findsWidgets);
    await tester.tap(seeMoreText.last);
    await tester.pumpAndSettle();

    expect(find.byType(TopRatedMoviesPage), findsOneWidget);
    expect(find.text('Top Rated Movies'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('open top rated tv series page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final movieButton = find.text('TV Series');
    expect(movieButton, findsOneWidget);
    await tester.tap(movieButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeMoviePage), findsWidgets);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    final seeMoreText = find.text('See More');
    expect(seeMoreText, findsWidgets);
    await tester.tap(seeMoreText.last);
    await tester.pumpAndSettle();

    expect(find.byType(TopRatedMoviesPage), findsOneWidget);
    expect(find.text('Top Rated TV Series'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('open movie detail page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final listView = find.byType(ListView);
    expect(listView, findsWidgets);
    await tester.tap(listView.first);
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailPage), findsOneWidget);
    expect(find.byKey(Key('image_detail')), findsOneWidget);
    expect(find.byKey(Key('title_detail')), findsOneWidget);
    expect(find.byKey(Key('genres')), findsOneWidget);
    expect(find.byKey(Key('duration')), findsOneWidget);
    expect(find.byKey(Key('rating')), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.byKey(Key('overview_value')), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(Key('recommendation_list')), findsOneWidget);
    expect(find.byKey(Key('watchlist_button')), findsOneWidget);

    final backButton = find.byKey(Key('back_button_detail'));
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('open tv series detail page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final listView = find.byType(ListView);
    expect(listView, findsWidgets);
    await tester.tap(listView.at(1));
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailPage), findsOneWidget);
    expect(find.byKey(Key('image_detail')), findsOneWidget);
    expect(find.byKey(Key('title_detail')), findsOneWidget);
    expect(find.byKey(Key('genres')), findsOneWidget);
    expect(find.byKey(Key('duration')), findsOneWidget);
    expect(find.byKey(Key('rating')), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.byKey(Key('overview_value')), findsOneWidget);
    expect(find.text('Seasons'), findsOneWidget);
    expect(find.byKey(Key('seasons_list')), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(Key('recommendation_list')), findsOneWidget);
    expect(find.byKey(Key('watchlist_button')), findsOneWidget);

    final backButton = find.byKey(Key('back_button_detail'));
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('save and remove watchlist movie', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final listView = find.byType(ListView);
    expect(listView, findsWidgets);
    await tester.tap(listView.first);
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailPage), findsOneWidget);
    final watchlistButton = find.byKey(Key('watchlist_button'));
    expect(watchlistButton, findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);
    await tester.pump(Duration(milliseconds: 50));
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);

    final backButton = find.byKey(Key('back_button_detail'));
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final watchlistMenu = find.text('Watchlist');
    expect(watchlistMenu, findsOneWidget);
    await tester.tap(watchlistMenu);
    await tester.pumpAndSettle();
    expect(find.byType(WatchlistPage), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);

    final watchlistMovie = find.byKey(Key('movie_watchlist_list'));
    expect(watchlistMovie, findsOneWidget);
    await tester.tap(find.byKey(Key('item_0')));
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailPage), findsOneWidget);
    final watchlistButton2 = find.byKey(Key('watchlist_button'));
    expect(watchlistButton2, findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
    await tester.tap(watchlistButton2);
    await tester.pump(Duration(seconds: 1));
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);

    final backButton2 = find.byKey(Key('back_button_detail'));
    await tester.tap(backButton2);
    await tester.pumpAndSettle();

    expect(find.byKey(Key('empty_message')), findsOneWidget);
  });

  testWidgets('open about page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final menuIcon = find.byKey(Key("menu_button"));
    await tester.tap(menuIcon);
    await tester.pumpAndSettle();

    final aboutButton = find.text('About');
    expect(aboutButton, findsOneWidget);
    await tester.tap(aboutButton);
    await tester.pumpAndSettle();

    final textAbout =
        'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.';

    expect(find.byType(AboutPage), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text(textAbout), findsOneWidget);

    final backButton = find.byKey(Key('back_button_about'));
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });
}
