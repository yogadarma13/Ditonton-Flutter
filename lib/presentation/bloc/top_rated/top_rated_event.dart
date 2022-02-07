import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';

class OnTopRatedRequest extends BlocEvent {
  final CategoryMovie category;

  OnTopRatedRequest(this.category);

  @override
  List<Object> get props => [category];
}
