import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = SearchTvSeries(mockTvRepository);
  });

  final tvSeries = <Movie>[];
  final tQuery = 'Victoria';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(tvSeries));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, Right(tvSeries));
  });
}
