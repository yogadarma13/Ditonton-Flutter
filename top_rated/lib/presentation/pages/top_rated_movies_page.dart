import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/top_rated_bloc.dart';
import '../bloc/top_rated_event.dart';

class TopRatedMoviesPage extends StatefulWidget {
  final CategoryMovie category;

  const TopRatedMoviesPage({required this.category});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedBloc>().add(OnTopRatedRequest(widget.category)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == CategoryMovie.Movies
            ? 'Top Rated Movies'
            : 'Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedBloc, BlocState>(
          builder: (context, state) {
            if (state is StateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie, widget.category);
                },
                itemCount: result.length,
              );
            } else if (state is StateError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
