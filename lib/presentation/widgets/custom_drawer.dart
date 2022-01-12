import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  CustomDrawer({
    required this.content,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  Widget _buildDrawer() {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://d17ivq9b7rppb3.cloudfront.net/original/jobs/turut_berkontribusi_memajungan_dunia_it_di_indonesia_270619074639.jpeg'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME, arguments: CategoryMovie.Movies);
              _animationController.reverse();
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV Series'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME, arguments: CategoryMovie.TvSeries);
              _animationController.reverse();
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              _animationController.reverse();
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              _animationController.reverse();
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }
}
