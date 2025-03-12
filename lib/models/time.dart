import 'package:flutter/material.dart';

@immutable
class Time {
  final String nome;
  final int setsVencidos;
  final int pontos;

  const Time({
    required this.nome,
    this.setsVencidos = 0,
    this.pontos = 0,
  });

  Time copyWith({
    String? nome,
    int? setsVencidos,
    int? pontos,
  }) =>
      Time(
        nome: nome ?? this.nome,
        setsVencidos: setsVencidos ?? this.setsVencidos,
        pontos: pontos ?? this.pontos,
      );

  String get nomeSetsVencidos => '$nome $setsVencidos';
}
