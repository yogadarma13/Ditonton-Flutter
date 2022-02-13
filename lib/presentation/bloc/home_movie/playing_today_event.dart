import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';

class OnPlayingTodayRequest extends BlocEvent {
  final CategoryMovie category;

  OnPlayingTodayRequest(this.category);

  @override
  List<Object> get props => [category];
}