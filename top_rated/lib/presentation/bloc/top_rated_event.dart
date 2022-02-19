import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/utils/state_enum.dart';

class OnTopRatedRequest extends BlocEvent {
  final CategoryMovie category;

  const OnTopRatedRequest(this.category);

  @override
  List<Object> get props => [category];
}
