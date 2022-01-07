import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetPopularTvSeries(mockMovieRepository);
  });

  final popularTvSeries = <Movie>[];

  test('should get list of popular tv series from the repository', () async {
    when(mockMovieRepository.getPopularTVSeries())
        .thenAnswer((_) async => Right(popularTvSeries));

    final resultList = await useCase.execute();
    expect(resultList, Right(popularTvSeries));
  });
}
