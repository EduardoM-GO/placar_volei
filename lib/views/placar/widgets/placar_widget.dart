import 'package:flutter/material.dart';
import 'package:placar_volei/views/placar/widgets/contador_de_ponto_widget.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';

class PlacarWidget extends StatefulWidget {
  const PlacarWidget({super.key});

  @override
  State<PlacarWidget> createState() => _PlacarWidgetState();
}

class _PlacarWidgetState extends State<PlacarWidget> {
  late PartidaViewModel controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PartidaViewModel.of(context);
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
              onChanged: (pontos) => controller.setPotuacao(pontosCasa: pontos),
            ),
          ),
          Expanded(
            child: ContadorDePontoWidget(
              ativo: controller.jogoEmAndamento,
              time: controller.timeVisitante,
              mensagem: controller.mensagemVisitante,
              onChanged: (pontos) =>
                  controller.setPotuacao(pontosVisitante: pontos),
            ),
          ),
        ],
      );
}
