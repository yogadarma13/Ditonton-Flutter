import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/domain/usecases/get_movie_detail.dart';
import 'package:detail/domain/usecases/get_tv_series_detail.dart';
import 'package:detail/presentation/bloc/detail_movie/detail_bloc.dart';
import 'package:detail/presentation/bloc/detail_movie/detail_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
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

  const tId = 1;
  const tvId = 13;

  test('initial state should be empty', () {
    expect(detailBloc.state, StateEmpty());
  });

  group('Detail Movies', () {
    blocTest<DetailBloc, BlocState>(
      'Should emit [Loading, HasData] when data detail movies is gotten successfully',
      build: () {
        when(mockGetMovieDetailUseCase.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const OnDetailRequest(CategoryMovie.Movies, tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        const StateHasData(testMovieDetail),
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
      act: (bloc) => bloc.add(const OnDetailRequest(CategoryMovie.Movies, tId)),
      expect: () => [
        StateLoading(),
        const StateError('Server Failure'),
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
            .thenAnswer((_) async => const Right(testTvDetail));
        return detailBloc;
      },
      act: (bloc) =>
          bloc.add(const OnDetailRequest(CategoryMovie.TvSeries, tvId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        StateLoading(),
        const StateHasData(testTvDetail),
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
      act: (bloc) =>
          bloc.add(const OnDetailRequest(CategoryMovie.TvSeries, tvId)),
      expect: () => [
        StateLoading(),
        const StateError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetailUseCase.execute(tvId));
      },
    );
  });
}
