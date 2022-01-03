import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  Movie({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  Movie.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  int id;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
      ];
}
