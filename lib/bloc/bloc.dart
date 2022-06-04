import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

abstract class Bloc<Event, State> {
  final PublishSubject<Event> _eventSubject = PublishSubject<Event>();
  late BehaviorSubject<State> _stateSubject;

  State get initialState;
  State get currentState => _stateSubject.value;
  Stream get state => _stateSubject.stream;

  Bloc() {
    _stateSubject = BehaviorSubject<State>.seeded(initialState);
    _bindStateSubject();
  }

  @mustCallSuper
  void dispose() {
    _eventSubject.close();
    _stateSubject.close();
  }

  void onError(Object error, StackTrace stackTrace);

  void onEvent(Event event);

  void dispatch(Event event) {
    try {
      onEvent(event);
      _eventSubject.sink.add(event);
    } on Exception catch (error) {
      _handlerError(error);
    }
  }

  Stream<State> transform(
    Stream<Event> events,
    Stream<State> Function(Event event) next,
  ) {
    return events.asyncExpand(next);
  }

  Stream<State> mapEventToState(Event event);

  void _bindStateSubject() {
    transform(
      _eventSubject,
      (Event event) => mapEventToState(event).handleError(_handlerError),
    ).forEach(
      (State nextState) {
        if (currentState == nextState || _stateSubject.isClosed) return;
        _stateSubject.sink.add(nextState);
      },
    );
  }

  void _handlerError(Object error, [StackTrace stackTrace = StackTrace.empty]) {
    onError(error, stackTrace);
  }
}
