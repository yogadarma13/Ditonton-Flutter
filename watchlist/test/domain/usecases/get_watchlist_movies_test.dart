import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'get_watchlist_movies_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetWatchlistMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistMovies(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies(CategoryMovie.Movies.name))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute(CategoryMovie.Movies.name);
    // assert
    expect(result, Right(testMovieList));
  });
}
