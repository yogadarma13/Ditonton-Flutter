import '../../../../utils/state_enum.dart';
import '../../bloc_event.dart';

class OnPlayingTodayRequest extends BlocEvent {
  final CategoryMovie category;

  const OnPlayingTodayRequest(this.category);

  @override
  List<Object> get props => [category];
}