import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/home/popular_movies/popular_movies_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMoviesUseCase);
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

  test('initial state should be empty', () {
    expect(popularMoviesBloc.state, StateEmpty());
  });

  blocTest<PopularMoviesBloc, BlocState>(
    'Should emit [Loading, HasData] when data popular movies is gotten successfully',
    build: () {
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesRequest()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      StateLoading(),
      StateHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMoviesUseCase.execute());
    },
  );

  blocTest<PopularMoviesBloc, BlocState>(
    'Should emit [Loading, Error] when get popular movies series is unsuccessful',
    build: () {
      when(mockGetPopularMoviesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesRequest()),
    expect: () => [
      StateLoading(),
      StateError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMoviesUseCase.execute());
    },
  );
}
