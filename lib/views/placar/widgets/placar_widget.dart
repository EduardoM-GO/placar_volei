import 'package:flutter/material.dart';
import 'package:placar_volei/views/placar/widgets/contador_de_ponto_widget.dart';
import 'package:placar_volei/views/placar/widgets/info_partida_widget.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';

class PlacarWidget extends StatefulWidget {
  const PlacarWidget({super.key});

  @override
  State<PlacarWidget> createState() => _PlacarWidgetState();
}

class _PlacarWidgetState extends State<PlacarWidget> {
  late PartidaViewModel controller;
  late ColorScheme colorScheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PartidaViewModel.of(context);
    colorScheme = Theme.of(context).colorScheme;
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: ColoredBox(
                color: colorScheme.primary,
              )),
              Expanded(
                  child: ColoredBox(
                color: colorScheme.secondary,
              )),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: ContadorDePontoWidget(
                  ativo: controller.jogoEmAndamento,
                  timeCasa: true,
                  time: controller.timeCasa,
                  mensagem: controller.mensagemCasa,
                  onChanged: (pontos) =>
                      controller.setPotuacao(pontosCasa: pontos),
                ),
              ),
              InfoPartidaWidget(),
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
          ),
        ],
      );
}
