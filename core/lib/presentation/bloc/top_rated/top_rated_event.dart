import '../../../utils/state_enum.dart';
import '../bloc_event.dart';

class OnTopRatedRequest extends BlocEvent {
  final CategoryMovie category;

  const OnTopRatedRequest(this.category);

  @override
  List<Object> get props => [category];
}
