import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home/airing_today/airing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/home/home_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeriesUseCase])
void main() {
  late AiringTodayBloc airingTodayBloc;
  late MockGetAiringTodayTvSeriesUseCase mockGetAiringTodayTvSeriesUseCase;

  setUp(() {
    mockGetAiringTodayTvSeriesUseCase = MockGetAiringTodayTvSeriesUseCase();
    airingTodayBloc = AiringTodayBloc(mockGetAiringTodayTvSeriesUseCase);
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
    expect(airingTodayBloc.state, StateEmpty());
  });

  blocTest<AiringTodayBloc, BlocState>(
    'Should emit [Loading, HasData] when data airing today tv series is gotten successfully',
    build: () {
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(OnHomeRequest()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      StateLoading(),
      StateHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeriesUseCase.execute());
    },
  );

  blocTest<AiringTodayBloc, BlocState>(
    'Should emit [Loading, Error] when get airing today tv series is unsuccessful',
    build: () {
      when(mockGetAiringTodayTvSeriesUseCase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(OnHomeRequest()),
    expect: () => [
      StateLoading(),
      StateError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeriesUseCase.execute());
    },
  );
}
