import 'package:flutter/material.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';

class FloatingActionOpcoesWidget extends StatefulWidget {
  const FloatingActionOpcoesWidget({super.key});

  @override
  State<FloatingActionOpcoesWidget> createState() =>
      _FloatingActionOpcoesWidgetState();
}

class _FloatingActionOpcoesWidgetState
    extends State<FloatingActionOpcoesWidget> {
  late PartidaViewModel controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PartidaViewModel.of(context);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Visibility(
            visible: controller.jogoEmAndamento,
            replacement: FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: controller.iniciarJogo,
              child: Icon(Icons.play_arrow),
            ),
            child: FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: controller.resetPlacar,
              child: Icon(Icons.refresh),
            ),
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: () => Navigator.of(context).pushNamed('/configuracao'),
            child: Icon(
              Icons.settings,
            ),
          )
        ],
      );
}
