import 'dart:convert';

import 'package:core/data/models/tv_model.dart';
import 'package:core/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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

  const tvResponseModel = TvResponse(tvList: [tvModel]);

  group('convert fromJson', () {
    test('should return a valid tv response model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today_tv_series.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tvResponseModel);
    });
  });

  group('convert toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/tv-series.jpg",
            "popularity": 87.9,
            "id": 1,
            "backdrop_path": "/tv-series-backdrop.jpg",
            "vote_average": 98.4,
            "overview": "Overview TV",
            "first_air_date": "2022-01-01",
            "origin_country": ["ID"],
            "genre_ids": [1, 2, 3],
            "original_language": "en",
            "vote_count": 14,
            "name": "TV Series Dicoding",
            "original_name": "Original Dicoding TV"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
