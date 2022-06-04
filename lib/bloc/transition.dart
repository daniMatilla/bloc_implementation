import 'package:equatable/equatable.dart';

class Transition<Event, State> extends Equatable {
  final State currentState;
  final Event event;
  final State nexttState;

  const Transition({
    required this.currentState,
    required this.event,
    required this.nexttState,
  })  : assert(currentState != null),
        assert(event != null),
        assert(nexttState != null);

  @override
  String toString() =>
      'Transition { currentState: $currentState, event: $event, nectState: $nexttState}';

  @override
  List<Object?> get props => [currentState, event, nexttState];
}
