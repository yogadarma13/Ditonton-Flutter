import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/utils/state_enum.dart';

class OnResetData extends BlocEvent {

  const OnResetData();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends BlocEvent {
  final String query;
  final CategoryMovie category;

  const OnQueryChanged(this.query, this.category);

  @override
  List<Object> get props => [query, category];
}
