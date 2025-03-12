import 'package:flutter/material.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';
import 'package:placar_volei/views_models/tema_app_view_model.dart';

final class DadosInheritedNotifierWidget
    extends InheritedNotifier<PartidaViewModel> {
  final TemaAppViewModel temaAppViewModel;

  const DadosInheritedNotifierWidget({
    super.key,
    required PartidaViewModel super.notifier,
    required this.temaAppViewModel,
    required super.child,
  });

  static PartidaViewModel of(BuildContext context) {
    final DadosInheritedNotifierWidget? result = context
        .dependOnInheritedWidgetOfExactType<DadosInheritedNotifierWidget>();
    assert(result != null, 'No PartidaViewModel found in context');
    return result!.notifier!;
  }

  static TemaAppViewModel ofThemeModeNotifier(BuildContext context) {
    final DadosInheritedNotifierWidget? result = context
        .dependOnInheritedWidgetOfExactType<DadosInheritedNotifierWidget>();
    assert(result != null, 'No PartidaViewModel found in context');
    return result!.temaAppViewModel;
  }
}
