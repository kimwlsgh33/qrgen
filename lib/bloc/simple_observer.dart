import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class SimpleObserver extends BlocObserver {
  static final Logger _logger = Logger();

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _logger.d(transition);
    super.onTransition(bloc, transition);
  }
}
