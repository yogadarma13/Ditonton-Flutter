part of 'watchlist_bloc.dart';

class WatchlistStatusState extends Equatable {
  final bool isAddedToWatchlist;

  const WatchlistStatusState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
