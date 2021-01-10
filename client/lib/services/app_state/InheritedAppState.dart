import 'package:flutter/widgets.dart';
import 'package:gonna_client/services/app_state/AppState.dart';

class InheritedAppState extends InheritedWidget {
  final AppState appState;

  InheritedAppState({
    Key key,
    @required Widget child,
    @required this.appState,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static InheritedAppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();
}
