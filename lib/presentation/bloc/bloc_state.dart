import 'package:equatable/equatable.dart';

abstract class BlocState extends Equatable {
  const BlocState();

  @override
  List<Object> get props => [];
}

class StateEmpty extends BlocState {}

class StateLoading extends BlocState {}

class StateError extends BlocState {
  final String message;

  StateError(this.message);

  @override
  List<Object> get props => [message];
}

class StateHasData<T> extends BlocState {
  final T result;

  StateHasData(this.result);

  @override
  List<Object> get props => [result as dynamic];
}
