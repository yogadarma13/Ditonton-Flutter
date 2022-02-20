import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/utils/state_enum.dart';

class OnPopularRequest extends BlocEvent {
  final CategoryMovie category;

  const OnPopularRequest(this.category);

  @override
  List<Object> get props => [category];
}
