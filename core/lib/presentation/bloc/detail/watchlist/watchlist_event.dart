import '../../../../domain/entities/movie_detail.dart';
import '../../bloc_event.dart';

class OnWatchlistStatusRequest extends BlocEvent {
  final int id;

  const OnWatchlistStatusRequest(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlistRequest extends BlocEvent {
  final MovieDetail movieDetail;
  final String category;

  const OnSaveWatchlistRequest(this.movieDetail, this.category);

  @override
  List<Object> get props => [movieDetail, category];
}

class OnRemoveWatchlistRequest extends BlocEvent {
  final MovieDetail movieDetail;

  const OnRemoveWatchlistRequest(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
