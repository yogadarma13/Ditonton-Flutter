import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMoviesUseCase,
])
void main() {
  late HomeNotifier provider;
  late MockGetNowPlayingMoviesUseCase mockGetNowPlayingMoviesUseCase;

  setUp(() {
    mockGetNowPlayingMoviesUseCase = MockGetNowPlayingMoviesUseCase();
    provider = HomeNotifier(
      getNowPlayingMovies: mockGetNowPlayingMoviesUseCase,
    );
  });

  final tMovie = Movie(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      verify(mockGetNowPlayingMoviesUseCase.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });
  });
}
