import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/bloc/home/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/home/popular_tv_series/popular_tv_series_event.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeriesUseCase])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeriesUseCase mockGetPopularTvSeriesUseCase;

  setUp(() {
    mockGetPopularTvSeriesUseCase = MockGetPopularTvSeriesUseCase();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeriesUseCase);
  });

  final tMovie = Movie(
    id: 2,
    overview: 'Synopsis',
    posterPath: 'poster',
    releaseDate: 'release',
    title: 'Movie1',
    voteAverage: 2,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(popularTvSeriesBloc.state, StateEmpty());
  });

  blocTest<PopularTvSeriesBloc, BlocState>(
    'Should emit [Loading, HasData] when data now playing movies is gotten successfully',
    build: () {
      when(mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnPopularTvSeriesRequest()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      StateLoading(),
      StateHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeriesUseCase.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, BlocState>(
    'Should emit [Loading, Error] when get now playing movies is unsuccessful',
    build: () {
      when(mockGetPopularTvSeriesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnPopularTvSeriesRequest()),
    expect: () => [
      StateLoading(),
      const StateError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeriesUseCase.execute());
    },
  );
}
