import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

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
