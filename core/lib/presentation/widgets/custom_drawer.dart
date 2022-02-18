import 'package:flutter/material.dart';

import '../../utils/routes.dart';
import '../../utils/state_enum.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  const CustomDrawer({
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
      duration: const Duration(milliseconds: 250),
    );
  }

  Widget _buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/37299231?v=4'),
          ),
          accountName: Text('Yoga Darma'),
          accountEmail: Text('kadekyoga125@gmail.com'),
        ),
        const ListTile(
          leading: Icon(Icons.home_filled),
          title: Text('Home'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () {
            Navigator.pushNamed(context, MOVIE_ROUTE,
                arguments: CategoryMovie.Movies);
            _animationController.reverse();
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('TV Series'),
          onTap: () {
            Navigator.pushNamed(context, MOVIE_ROUTE,
                arguments: CategoryMovie.TvSeries);
            _animationController.reverse();
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist'),
          onTap: () {
            Navigator.pushNamed(context, WATCHLIST_ROUTE);
            _animationController.reverse();
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, ABOUT_ROUTE);
            _animationController.reverse();
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
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
