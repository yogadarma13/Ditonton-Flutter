import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  MovieDetail({
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.seasons,
  });

  final List<Genre> genres;
  final int id;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final List<Season>? seasons;

  @override
  List<Object?> get props => [
        genres,
        id,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        seasons
      ];
}
