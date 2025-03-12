import 'package:flutter/material.dart';
import 'package:placar_volei/views/placar/widgets/info_partida_widget.dart';
import 'package:placar_volei/views/placar/widgets/opcoes_widget.dart.dart';
import 'package:placar_volei/views/placar/widgets/placar_widget.dart';

class PlacarView extends StatefulWidget {
  const PlacarView({super.key});

  @override
  State<PlacarView> createState() => _PlacarViewState();
}

class _PlacarViewState extends State<PlacarView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            PlacarWidget(),
            OpcoesWidgetDart(),
            InfoPartidaWidget(),
          ],
        ),
      );
}
