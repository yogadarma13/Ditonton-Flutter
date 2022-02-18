import 'package:core/data/models/tv_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tvModel = TvModel(
      posterPath: "/tv-series.jpg",
      popularity: 87.9,
      id: 1,
      backdropPath: "/tv-series-backdrop.jpg",
      voteAverage: 98.4,
      overview: "Overview TV",
      firstAirDate: "2022-01-01",
      originCountry: ["ID"],
      genreIds: [1, 2, 3],
      originalLanguage: "en",
      voteCount: 14,
      name: "TV Series Dicoding",
      originalName: "Original Dicoding TV");

  final movie = Movie(
      id: 1,
      overview: "Overview TV",
      posterPath: "/tv-series.jpg",
      releaseDate: "2022-01-01",
      title: "TV Series Dicoding",
      voteAverage: 98.4);

  test('should be a subclass of Movie entity', () async {
    final result = tvModel.toEntity();
    expect(result, movie);
  });
}
