import 'package:flutter/material.dart';
import 'package:placar_volei/models/time.dart';

@immutable
class Placar {
  final Time casa;
  final Time visitante;

  const Placar._({required this.casa, required this.visitante});

  factory Placar.empty() => const Placar._(
        casa: Time(nome: 'Casa'),
        visitante: Time(nome: 'Visitante'),
      );

  Placar copyWith({
    Time? casa,
    Time? visitante,
  }) =>
      Placar._(
        casa: casa ?? this.casa,
        visitante: visitante ?? this.visitante,
      );

  Placar zerarPontos() => Placar._(
        casa: casa.atualizarPontos(0),
        visitante: visitante.atualizarPontos(0),
      );
}
