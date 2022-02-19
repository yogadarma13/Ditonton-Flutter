import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/utils/state_enum.dart';

class OnDetailRequest extends BlocEvent {
  final CategoryMovie category;
  final int id;

  const OnDetailRequest(this.category, this.id);

  @override
  List<Object> get props => [category, id];
}
