import 'package:flutter/material.dart';
import 'package:placar_volei/views_models/tempo_partida_view_model.dart';

class TempoDePartidaWidget extends StatelessWidget {
  final TempoPartidaViewModel controller;
  const TempoDePartidaWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: controller,
        builder: (context, _) => Text(
          controller.tempo,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 50,
          ),
        ),
      );
}
