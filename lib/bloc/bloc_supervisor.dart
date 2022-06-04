import 'bloc_delegate.dart';

class BlocSupervisor {
  BlocSupervisor._();

  static final _instance = BlocSupervisor._();

  BlocDelegate _delegate = BlocDelegate();
  static BlocDelegate get delegate => _instance._delegate;
  static set delegate(BlocDelegate? delegate) {
    _instance._delegate = delegate ?? BlocDelegate();
  }
}
