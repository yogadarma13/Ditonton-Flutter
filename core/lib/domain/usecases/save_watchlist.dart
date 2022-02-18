import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

abstract class SaveWatchlistUseCase {
  Future<Either<Failure, String>> execute(MovieDetail movie, String category);
}

class SaveWatchlist implements SaveWatchlistUseCase {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  @override
  Future<Either<Failure, String>> execute(MovieDetail movie, String category) {
    return repository.saveWatchlist(movie, category);
  }
}
