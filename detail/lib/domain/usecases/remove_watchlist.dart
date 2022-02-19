import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

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
