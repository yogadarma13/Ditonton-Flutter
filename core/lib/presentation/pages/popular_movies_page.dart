import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/state_enum.dart';
import '../bloc/bloc_state.dart';
import '../bloc/popular/popular_bloc.dart';
import '../bloc/popular/popular_event.dart';
import '../widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  final CategoryMovie category;

  const PopularMoviesPage({required this.category});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularBloc>().add(OnPopularRequest(widget.category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == CategoryMovie.Movies
            ? 'Popular Movies'
            : 'Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularBloc, BlocState>(
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
