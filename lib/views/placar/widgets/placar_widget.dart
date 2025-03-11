import 'package:flutter/material.dart';
import 'package:placar_volei/controllers/placar_controller.dart';
import 'package:placar_volei/views/placar/widgets/contador_de_ponto_widget.dart';

class PlacarWidget extends StatefulWidget {
  const PlacarWidget({super.key});

  @override
  State<PlacarWidget> createState() => _PlacarWidgetState();
}

class _PlacarWidgetState extends State<PlacarWidget> {
  late PlacarController controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PlacarController.of(context);
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: ContadorDePontoWidget(
              ativo: controller.jogoEmAndamento,
              timeCasa: true,
              time: controller.timeCasa,
              mensagem: controller.mensagemCasa,
              onChanged: (time) => controller.timeCasa = time,
            ),
          ),
          Expanded(
            child: ContadorDePontoWidget(
              ativo: controller.jogoEmAndamento,
              time: controller.timeVisitante,
              mensagem: controller.mensagemVisitante,
              onChanged: (time) => controller.timeVisitante = time,
            ),
          ),
        ],
      );
}
