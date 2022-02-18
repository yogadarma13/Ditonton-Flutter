import '../../../../utils/state_enum.dart';
import '../../bloc_event.dart';

class OnDetailRequest extends BlocEvent {
  final CategoryMovie category;
  final int id;

  const OnDetailRequest(this.category, this.id);

  @override
  List<Object> get props => [category, id];
}
