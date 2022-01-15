import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

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
