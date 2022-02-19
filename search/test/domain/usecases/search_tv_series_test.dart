import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

import 'search_tv_series_test.mocks.dart';

@GenerateMocks([TvRepository])
void main() {
  late SearchTvSeries useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = SearchTvSeries(mockTvRepository);
  });

  final tvSeries = <Movie>[];
  const tQuery = 'Victoria';

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
