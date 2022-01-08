import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetTvSeriesDetail(mockMovieRepository);
  });

  final tId = 1;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getTVSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });
}
