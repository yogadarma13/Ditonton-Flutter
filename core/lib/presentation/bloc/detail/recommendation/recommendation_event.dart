import '../../../../utils/state_enum.dart';
import '../../bloc_event.dart';

class OnRecommendationRequest extends BlocEvent {
  final CategoryMovie category;
  final int id;

  const OnRecommendationRequest(this.category, this.id);

  @override
  List<Object> get props => [category, id];
}