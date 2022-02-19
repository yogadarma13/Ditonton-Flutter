import '../../../../utils/state_enum.dart';
import '../../bloc_event.dart';

class OnPopularRequest extends BlocEvent {
  final CategoryMovie category;

  const OnPopularRequest(this.category);

  @override
  List<Object> get props => [category];
}