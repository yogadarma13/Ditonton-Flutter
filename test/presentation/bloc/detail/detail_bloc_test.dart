import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/detail/detail_movie/detail_bloc.dart';
import 'package:ditonton/presentation/bloc/detail/detail_movie/detail_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetailUseCase, GetTvSeriesDetailUseCase])
void main() {
  late DetailBloc detailBloc;
  late MockGetMovieDetailUseCase mockGetMovieDetailUseCase;
  late MockGetTvSeriesDetailUseCase mockGetTvSeriesDetailUseCase;

  setUp(() {
    mockGetMovieDetailUseCase = MockGetMovieDetailUseCase();
    mockGetTvSeriesDetailUseCase = MockGetTvSeriesDetailUseCase();
    detailBloc =
        DetailBloc(mockGetMovieDetailUseCase, mockGetTvSeriesDetailUseCase);
  });

  final tId = 1;
  final tvId = 13;

  test('initial state should be empty', () {
    expect(detailBloc.state, StateEmpty());
  });

  group('Detail Movies', () {
    blocTest<DetailBloc, BlocState>(
      'Should emit [Loading, HasData] when data detail movies is gotten successfully',
      build: () {
        when(mockGetMovieDetailUseCase.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(OnDetailRequest(CategoryMovie.Movies, tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetailUseCase.execute(tId));
      },
    );

    blocTest<DetailBloc, BlocState>(
      'Should emit [Loading, Error] when get detail movies is unsuccessful',
      build: () {
        when(mockGetMovieDetailUseCase.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(OnDetailRequest(CategoryMovie.Movies, tId)),
      expect: () => [
        StateLoading(),
        StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetailUseCase.execute(tId));
      },
    );
  });

  group('Detail TV Series', () {
    blocTest<DetailBloc, BlocState>(
      'Should emit [Loading, HasData] when data detail tv series is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetailUseCase.execute(tvId))
            .thenAnswer((_) async => Right(testTvDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(OnDetailRequest(CategoryMovie.TvSeries, tvId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        StateHasData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetailUseCase.execute(tvId));
      },
    );

    blocTest<DetailBloc, BlocState>(
      'Should emit [Loading, Error] when get detail tv series is unsuccessful',
      build: () {
        when(mockGetTvSeriesDetailUseCase.execute(tvId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(OnDetailRequest(CategoryMovie.TvSeries, tvId)),
      expect: () => [
        StateLoading(),
        StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetailUseCase.execute(tvId));
      },
    );
  });
}