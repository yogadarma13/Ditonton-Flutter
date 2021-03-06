import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlist(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(
            testMovieDetail, CategoryMovie.Movies.name))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result =
        await usecase.execute(testMovieDetail, CategoryMovie.Movies.name);
    // assert
    verify(mockMovieRepository.saveWatchlist(
        testMovieDetail, CategoryMovie.Movies.name));
    expect(result, const Right('Added to Watchlist'));
  });
}
