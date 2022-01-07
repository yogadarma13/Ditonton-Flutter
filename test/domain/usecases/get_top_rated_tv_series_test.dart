import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetTopRatedTvSeries(mockMovieRepository);
  });

  final topRatedTvSeries = <Movie>[];

  test('should get list of top rated tv series from repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedTVSeries())
        .thenAnswer((_) async => Right(topRatedTvSeries));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(topRatedTvSeries));
  });
}
