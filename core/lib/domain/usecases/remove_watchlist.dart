import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

abstract class RemoveWatchlistUseCase {
  Future<Either<Failure, String>> execute(MovieDetail movie);
}

class RemoveWatchlist implements RemoveWatchlistUseCase {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  @override
  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
