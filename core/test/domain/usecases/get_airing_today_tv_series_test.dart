import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_airing_today_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTodayTvSeries useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = GetAiringTodayTvSeries(mockTvRepository);
  });

  final tvSeries = <Movie>[];

  test('should get list of airing today tv series from the repository',
      () async {
    when(mockTvRepository.getAiringTodayTVSeries())
        .thenAnswer((_) async => Right(tvSeries));

    final result = await useCase.execute();
    expect(result, Right(tvSeries));
  });
}
