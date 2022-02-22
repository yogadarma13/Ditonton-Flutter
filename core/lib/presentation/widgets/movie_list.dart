import 'package:cached_network_image/cached_network_image.dart';
import 'package:detail/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';
import '../../utils/state_enum.dart';

class MovieList extends StatelessWidget {
  final String parentKey;
  final List<Movie> movies;
  final CategoryMovie category;

  const MovieList(this.parentKey, this.movies, this.category);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            key: Key("${parentKey}_$index"),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_ROUTE,
                  arguments:
                      DetailScreenArguments(id: movie.id, category: category),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
