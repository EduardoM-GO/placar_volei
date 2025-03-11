import 'package:flutter/material.dart';
import 'package:placar_volei/controllers/placar_controller.dart';

class OpcoesWidgetDart extends StatefulWidget {
  const OpcoesWidgetDart({super.key});

  @override
  State<OpcoesWidgetDart> createState() => _OpcoesWidgetDartState();
}

class _OpcoesWidgetDartState extends State<OpcoesWidgetDart> {
  late PlacarController controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PlacarController.of(context);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Visibility(
                visible: controller.jogoEmAndamento,
                replacement: ElevatedButton.icon(
                  onPressed: controller.iniciarJogo,
                  label: Text('Iniciar Jogo'),
                  icon: Icon(Icons.play_arrow),
                ),
                child: ElevatedButton.icon(
                  onPressed: controller.resetPlacar,
                  label: const Text('Resetar Placar'),
                  icon: Icon(Icons.refresh),
                ),
              ),
            ],
          ),
        ),
      );
}
