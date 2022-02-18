import '../repositories/movie_repository.dart';

abstract class GetWatchListStatusUseCase {
  Future<bool> execute(int id);
}

class GetWatchListStatus implements GetWatchListStatusUseCase {
  final MovieRepository repository;

  GetWatchListStatus(this.repository);

  @override
  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
