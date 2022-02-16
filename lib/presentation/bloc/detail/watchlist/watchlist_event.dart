import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';

class OnWatchlistStatusRequest extends BlocEvent {
  final int id;

  OnWatchlistStatusRequest(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlistRequest extends BlocEvent {
  final MovieDetail movieDetail;
  final String category;

  OnSaveWatchlistRequest(this.movieDetail, this.category);

  @override
  List<Object> get props => [movieDetail, category];
}

class OnRemoveWatchlistRequest extends BlocEvent {
  final MovieDetail movieDetail;

  OnRemoveWatchlistRequest(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}