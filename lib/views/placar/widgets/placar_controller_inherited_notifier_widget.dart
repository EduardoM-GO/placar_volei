import 'package:flutter/material.dart';
import 'package:placar_volei/controllers/placar_controller.dart';

class PlacarControllerInheritedNotifierWidget
    extends InheritedNotifier<PlacarController> {
  const PlacarControllerInheritedNotifierWidget({
    super.key,
    required super.child,
    required PlacarController super.notifier,
  });

  static PlacarController of(BuildContext context) {
    final PlacarControllerInheritedNotifierWidget? result =
        context.dependOnInheritedWidgetOfExactType<
            PlacarControllerInheritedNotifierWidget>();
    assert(result != null, 'No PlacarController found in context');

    return result!.notifier!;
  }
}
