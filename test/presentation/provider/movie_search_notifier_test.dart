import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMoviesUseCase, SearchTvSeriesUseCase])
void main() {
  late MovieSearchNotifier provider;
  late MockSearchMoviesUseCase mockSearchMoviesUseCase;
  late MockSearchTvSeriesUseCase mockSearchTvSeriesUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMoviesUseCase = MockSearchMoviesUseCase();
    mockSearchTvSeriesUseCase = MockSearchTvSeriesUseCase();
    provider = MovieSearchNotifier(
        searchMovies: mockSearchMoviesUseCase,
        searchTvSeries: mockSearchTvSeriesUseCase)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tMovieModel = Movie(
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    voteAverage: 7.2,
  );

  final tvModel = Movie(
    id: 67419,
    overview:
        "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
    posterPath: '/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg',
    releaseDate: '2016-08-28',
    title: 'Victoria',
    voteAverage: 1.39,
  );

  final tMovieList = <Movie>[tMovieModel];
  final tMovieList2 = <Movie>[tvModel];
  final tQuery = 'spiderman';
  final tQuery2 = 'victoria';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMoviesUseCase.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMoviesUseCase.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMoviesUseCase.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('search tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvSeriesUseCase.execute(tQuery2))
          .thenAnswer((_) async => Right(tMovieList2));
      // act
      provider.fetchMovieSearch(tQuery2, CategoryMovie.TvSeries);
      // assert
      expect(provider.state, RequestState.Loading);
    });
  });
}
