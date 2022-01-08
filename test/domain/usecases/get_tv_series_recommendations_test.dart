import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetTvSeriesRecommendations(mockMovieRepository);
  });

  final tId = 13;
  final tMovies = <Movie>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getTVSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(tMovies));
  });
}
