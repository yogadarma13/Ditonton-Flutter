import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMoviesUseCase, SearchTvSeriesUseCase])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMoviesUseCase mockSearchMoviesUseCase;
  late MockSearchTvSeriesUseCase mockSearchTvSeriesUseCase;

  setUp(() {
    mockSearchMoviesUseCase = MockSearchMoviesUseCase();
    mockSearchTvSeriesUseCase = MockSearchTvSeriesUseCase();
    searchBloc = SearchBloc(mockSearchMoviesUseCase, mockSearchTvSeriesUseCase);
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

  test('initial state should be empty', () {
    expect(searchBloc.state, StateEmpty());
  });

  group('Search Movies', () {
    blocTest<SearchBloc, BlocState>(
      'Should emit [Loading, HasData] when data movies is gotten successfully',
      build: () {
        when(mockSearchMoviesUseCase.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery, CategoryMovie.Movies)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        StateLoading(),
        StateHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMoviesUseCase.execute(tQuery));
      },
    );

    blocTest<SearchBloc, BlocState>(
      'Should emit [Loading, Error] when get search movies is unsuccessful',
      build: () {
        when(mockSearchMoviesUseCase.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery, CategoryMovie.Movies)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        StateLoading(),
        StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMoviesUseCase.execute(tQuery));
      },
    );

    blocTest<SearchBloc, BlocState>(
      'Should emit empty data when function reset called',
      build: () {
        when(mockSearchMoviesUseCase.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => {bloc.add(OnResetData())},
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateHasData([]),
      ],
    );
  });

  group('Search TV Series', () {
    blocTest<SearchBloc, BlocState>(
      'Should emit [Loading, HasData] when data tv series is gotten successfully',
      build: () {
        when(mockSearchTvSeriesUseCase.execute(tQuery2))
            .thenAnswer((_) async => Right(tMovieList2));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery2, CategoryMovie.TvSeries)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        StateLoading(),
        StateHasData(tMovieList2),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeriesUseCase.execute(tQuery2));
      },
    );

    blocTest<SearchBloc, BlocState>(
      'Should emit [Loading, Error] when get search tv series is unsuccessful',
      build: () {
        when(mockSearchTvSeriesUseCase.execute(tQuery2))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery2, CategoryMovie.TvSeries)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        StateLoading(),
        StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeriesUseCase.execute(tQuery2));
      },
    );

    blocTest<SearchBloc, BlocState>(
      'Should emit empty data when function reset called',
      build: () {
        when(mockSearchTvSeriesUseCase.execute(tQuery2))
            .thenAnswer((_) async => Right(tMovieList2));
        return searchBloc;
      },
      act: (bloc) => {bloc.add(OnResetData())},
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateHasData([]),
      ],
    );
  });
}
