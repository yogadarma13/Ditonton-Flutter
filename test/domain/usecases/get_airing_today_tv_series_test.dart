import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTodayTvSeries useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetAiringTodayTvSeries(mockMovieRepository);
  });

  final tvSeries = <Movie>[];

  test('should get list of airing today tv series from the repository',
      () async {
    when(mockMovieRepository.getAiringTodayTVSeries())
        .thenAnswer((_) async => Right(tvSeries));

    final result = await useCase.execute();
    expect(result, Right(tvSeries));
  });
}
