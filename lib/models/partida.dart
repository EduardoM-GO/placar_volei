import 'package:flutter/material.dart';
import 'package:placar_volei/models/time.dart';
import 'package:placar_volei/models/tipo_time_enum.dart';

@immutable
class Partida {
  final Time casa;
  final Time visitante;
  final Duration tempo;
  final bool emAndamento;
  final List<TipoTimeEnum> historicoPotuacao;

  const Partida({
    required this.casa,
    required this.visitante,
    required this.tempo,
    required this.emAndamento,
    required this.historicoPotuacao,
  });

  Partida copyWith({
    Time? casa,
    Time? visitante,
    Duration? tempo,
    bool? emAndamento,
    List<TipoTimeEnum>? historicoPotuacao,
  }) =>
      Partida(
        casa: casa ?? this.casa,
        visitante: visitante ?? this.visitante,
        tempo: tempo ?? this.tempo,
        emAndamento: emAndamento ?? this.emAndamento,
        historicoPotuacao: historicoPotuacao ?? this.historicoPotuacao,
      );
}
