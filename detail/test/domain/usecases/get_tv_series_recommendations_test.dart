import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetTvSeriesRecommendations(mockTvRepository);
  });

  const tId = 13;
  final tMovies = <Movie>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTVSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(tMovies));
  });
}
