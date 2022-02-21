import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';

class SearchPage extends StatefulWidget {
  final CategoryMovie category;

  const SearchPage(this.category);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          context.read<SearchBloc>().add(const OnResetData()),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == CategoryMovie.Movies
              ? 'Search Movies'
              : 'Search TV Series',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context
                    .read<SearchBloc>()
                    .add(OnQueryChanged(query, widget.category));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchBloc, BlocState>(
              builder: (context, state) {
                if (state is StateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StateHasData) {
                  final result = state.result;
                  return Expanded(
                    child: result.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie, widget.category);
                            },
                            itemCount: result.length,
                          )
                        : SingleChildScrollView(
                            child: Center(
                              key: const Key('empty_message'),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/empty.png',
                                    width: 240,
                                    height: 240,
                                    key: const Key('empty_image'),
                                  ),
                                  const Text(
                                    'No Data',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  );
                } else if (state is StateError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
