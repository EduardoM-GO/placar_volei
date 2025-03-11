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

  Time atualizarPontos(int pontos) => Time(
        nome: nome,
        setsVencidos: setsVencidos,
        pontos: pontos,
      );

  Time atualizarSetsVencidos(int setsVencidos) => Time(
        nome: nome,
        setsVencidos: setsVencidos,
        pontos: pontos,
      );
}
