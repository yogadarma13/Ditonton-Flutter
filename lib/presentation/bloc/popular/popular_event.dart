import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';

class OnPopularRequest extends BlocEvent {
  final CategoryMovie category;

  OnPopularRequest(this.category);

  @override
  List<Object> get props => [category];
}