import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';

class OnDetailRequest extends BlocEvent {
  final CategoryMovie category;
  final int id;

  OnDetailRequest(this.category, this.id);

  @override
  List<Object> get props => [category, id];
}
