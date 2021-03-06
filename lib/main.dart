import 'package:about/about.dart';
import 'package:core/common/utils.dart';
import 'package:core/core.dart';
import 'package:core/data/datasources/client/IOHttpClient.dart';
import 'package:core/presentation/bloc/home/airing_today/airing_today_bloc.dart';
import 'package:core/presentation/bloc/home/now_playing/now_playing_bloc.dart';
import 'package:core/presentation/bloc/home/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/home/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:detail/detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_movie/home_movie.dart';
import 'package:popular/popular.dart';
import 'package:search/search.dart';
import 'package:top_rated/top_rated.dart';
import 'package:watchlist/watchlist.dart';

import '../injection.dart' as di;

void main({Environment environment = Environment.Prod}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await IOHttpClient.init();
  di.init(environment);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AiringTodayBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PlayingTodayBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
          child: CustomDrawer(
            content: HomePage(),
          ),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => HomePage(),
              );
            case MOVIE_ROUTE:
              final category = settings.arguments as CategoryMovie;
              return MaterialPageRoute(
                builder: (_) => HomeMoviePage(
                  category: category,
                ),
                settings: settings,
              );
            case POPULAR_ROUTE:
              final category = settings.arguments as CategoryMovie;
              return CupertinoPageRoute(
                builder: (_) => PopularMoviesPage(
                  category: category,
                ),
              );
            case TOP_RATED_ROUTE:
              final category = settings.arguments as CategoryMovie;
              return CupertinoPageRoute(
                builder: (_) => TopRatedMoviesPage(
                  category: category,
                ),
              );
            case DETAIL_ROUTE:
              final arguments = settings.arguments as DetailScreenArguments;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(
                  arguments: arguments,
                ),
                settings: settings,
              );
            case SEARCH_ROUTE:
              final category = settings.arguments as CategoryMovie;
              return CupertinoPageRoute(builder: (_) => SearchPage(category));
            case WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
