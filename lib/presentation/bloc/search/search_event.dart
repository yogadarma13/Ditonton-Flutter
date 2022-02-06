part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchEvent {
  final String query;
  final CategoryMovie category;

  OnQueryChanged(this.query, this.category);

  @override
  List<Object> get props => [query];
}