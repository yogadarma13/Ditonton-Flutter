import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter/material.dart';

class SeasonTvCardList extends StatelessWidget {
  final Season season;

  SeasonTvCardList(this.season);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
              width: 100,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            season.name ?? "-",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "${season.episodeCount} episodes",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
