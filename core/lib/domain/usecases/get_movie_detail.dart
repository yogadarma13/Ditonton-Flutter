import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

abstract class GetMovieDetailUseCase {
  Future<Either<Failure, MovieDetail>> execute(int id);
}

class GetMovieDetail implements GetMovieDetailUseCase {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  @override
  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
