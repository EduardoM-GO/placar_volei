import 'package:flutter/material.dart';
import 'package:placar_volei/controllers/placar_controller.dart';
import 'package:placar_volei/views/placar/widgets/info_partida_widget.dart';
import 'package:placar_volei/views/placar/widgets/opcoes_widget.dart.dart';
import 'package:placar_volei/views/placar/widgets/placar_controller_inherited_notifier_widget.dart';
import 'package:placar_volei/views/placar/widgets/placar_widget.dart';

class PlacarView extends StatefulWidget {
  const PlacarView({super.key});

  @override
  State<PlacarView> createState() => _PlacarViewState();
}

class _PlacarViewState extends State<PlacarView> {
  late final PlacarController controller;

  @override
  void initState() {
    super.initState();
    controller = PlacarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PlacarControllerInheritedNotifierWidget(
          notifier: controller,
          child: Stack(
            children: [
              PlacarWidget(),
              OpcoesWidgetDart(),
              InfoPartidaWidget(),
            ],
          ),
        ),
      );
}
