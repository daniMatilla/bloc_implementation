import 'package:meta/meta.dart';

import 'bloc.dart';
import 'transition.dart';

class BlocDelegate {
  @mustCallSuper
  void onEvent(Bloc bloc, Object event) {}

  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) {}

  @mustCallSuper
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {}
}
