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
  late double heightText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PartidaViewModel.of(context);
    colorScheme = Theme.of(context).colorScheme;
    heightText = MediaQuery.of(context).size.height * 0.1;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        left: false,
        right: false,
        child: Column(
          spacing: 10,
          children: [
            Text(
              controller.placarSets,
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: heightText,
              ),
            ),
            ListenableBuilder(
              listenable: controller.tempoPartidaController,
              builder: (context, _) => Text(
                controller.tempoPartidaController.tempo,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: heightText,
                ),
              ),
            ),
          ],
        ),
      );
}
