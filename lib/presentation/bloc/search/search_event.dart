import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';

class OnResetData extends BlocEvent {

  OnResetData();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends BlocEvent {
  final String query;
  final CategoryMovie category;

  OnQueryChanged(this.query, this.category);

  @override
  List<Object> get props => [query, category];
}
