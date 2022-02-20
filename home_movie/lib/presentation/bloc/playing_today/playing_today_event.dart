import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/utils/state_enum.dart';

class OnPlayingTodayRequest extends BlocEvent {
  final CategoryMovie category;

  const OnPlayingTodayRequest(this.category);

  @override
  List<Object> get props => [category];
}
