import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

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

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });
  });
}
