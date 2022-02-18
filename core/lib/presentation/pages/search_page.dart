import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/text_styles.dart';
import '../../utils/state_enum.dart';
import '../bloc/bloc_state.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/search/search_event.dart';
import '../widgets/movie_card_list.dart';

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
          context.read<SearchBloc>().add(OnResetData()),
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
