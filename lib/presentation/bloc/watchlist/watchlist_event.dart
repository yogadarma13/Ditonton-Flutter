import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnWatchlistRequest extends WatchlistEvent {

  OnWatchlistRequest();

  @override
  List<Object> get props => [];
}