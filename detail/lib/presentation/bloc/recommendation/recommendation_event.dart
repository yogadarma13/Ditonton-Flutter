import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/utils/state_enum.dart';

class OnRecommendationRequest extends BlocEvent {
  final CategoryMovie category;
  final int id;

  const OnRecommendationRequest(this.category, this.id);

  @override
  List<Object> get props => [category, id];
}
