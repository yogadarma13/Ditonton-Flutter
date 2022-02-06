part of 'top_rated_bloc.dart';

abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnTopRatedRequest extends TopRatedEvent {
  final CategoryMovie category;

  OnTopRatedRequest(this.category);

  @override
  List<Object> get props => [category];
}
