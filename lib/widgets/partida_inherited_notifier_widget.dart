import 'package:flutter/material.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';

class PartidaInheritedNotifierWidget
    extends InheritedNotifier<PartidaViewModel> {
  const PartidaInheritedNotifierWidget({
    super.key,
    required PartidaViewModel super.notifier,
    required super.child,
  });

  static PartidaViewModel of(BuildContext context) {
    final PartidaInheritedNotifierWidget? result = context
        .dependOnInheritedWidgetOfExactType<PartidaInheritedNotifierWidget>();
    assert(result != null, 'No PartidaViewModel found in context');
    return result!.notifier!;
  }
}
