import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

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
