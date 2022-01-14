import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = SearchTvSeries(mockMovieRepository);
  });

  final tvSeries = <Movie>[];
  final tQuery = 'Victoria';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, Right(tvSeries));
  });
}
