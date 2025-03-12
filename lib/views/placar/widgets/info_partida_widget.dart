import 'package:flutter/material.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';

class InfoPartidaWidget extends StatefulWidget {
  const InfoPartidaWidget({super.key});

  @override
  State<InfoPartidaWidget> createState() => _InfoPartidaWidgetState();
}

class _InfoPartidaWidgetState extends State<InfoPartidaWidget> {
  late PartidaViewModel controller;
  late ColorScheme colorScheme;
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PartidaViewModel.of(context);
    colorScheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        left: false,
        right: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ListenableBuilder(
            listenable: controller.tempoPartidaController,
            builder: (context, _) => Text(
              controller.tempoPartidaController.tempo,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 50,
              ),
            ),
          ),
        ),
      );
}
