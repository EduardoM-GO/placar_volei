import 'dart:async';

import 'package:placar_volei/models/time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static CacheHelper? _instance;
  final SharedPreferences _sharedPreferences;

  CacheHelper._(this._sharedPreferences);

  static FutureOr<CacheHelper> get instance async =>
      _instance ??= CacheHelper._(await SharedPreferences.getInstance());

  Time get timeCasa => _getTime(true);

  Time get timeVisitante => _getTime(false);

  Time _getTime(bool timeCasa) {
    final _CacheKey nome =
        timeCasa ? _CacheKey.timeCasaNome : _CacheKey.timeVisitanteNome;
    final _CacheKey setsVencidos = timeCasa
        ? _CacheKey.timeCasaSetsVencidos
        : _CacheKey.timeVisitanteSetsVencidos;
    final _CacheKey pontos =
        timeCasa ? _CacheKey.timeCasaPontos : _CacheKey.timeVisitantePontos;

    final String nomeTimePadrao = timeCasa ? 'Casa' : 'Visitante';

    return Time(
      nome: _sharedPreferences.getString(nome.name) ?? nomeTimePadrao,
      setsVencidos: _sharedPreferences.getInt(setsVencidos.name) ?? 0,
      pontos: _sharedPreferences.getInt(pontos.name) ?? 0,
    );
  }

  Future<void> setTimeNome({
    String? nomeCasa,
    String? nomeVisitante,
  }) async {
    if (nomeCasa != null) {
      await _sharedPreferences.setString(_CacheKey.timeCasaNome.name, nomeCasa);
    }
    if (nomeVisitante != null) {
      await _sharedPreferences.setString(
          _CacheKey.timeVisitanteNome.name, nomeVisitante);
    }
  }

  Future<void> setTimeSetsVencidos({
    int? casa,
    int? visitante,
  }) async {
    if (casa != null) {
      await _sharedPreferences.setInt(
          _CacheKey.timeCasaSetsVencidos.name, casa);
    }
    if (visitante != null) {
      await _sharedPreferences.setInt(
          _CacheKey.timeVisitanteSetsVencidos.name, visitante);
    }
  }

  Future<void> setTimePontos({
    int? casa,
    int? visitante,
  }) async {
    if (casa != null) {
      await _sharedPreferences.setInt(_CacheKey.timeCasaPontos.name, casa);
    }
    if (visitante != null) {
      await _sharedPreferences.setInt(
          _CacheKey.timeVisitantePontos.name, visitante);
    }
  }

  ///Tempo da partida

  Duration get tempoPartida => Duration(
        seconds: _sharedPreferences.getInt(_CacheKey.tempoPartida.name) ?? 0,
      );

  Future<void> setTempoPartida(Duration tempoPartida) async =>
      await _sharedPreferences.setInt(
          _CacheKey.tempoPartida.name, tempoPartida.inSeconds);

  bool get jogoEmAndamento =>
      _sharedPreferences.getBool(_CacheKey.jogoEmAndamento.name) ?? false;

  Future<void> setJogoEmAndamento(bool jogoEmAndamento) async =>
      await _sharedPreferences.setBool(
          _CacheKey.jogoEmAndamento.name, jogoEmAndamento);
}

enum _CacheKey {
  tempoPartida,
  timeCasaNome,
  timeCasaSetsVencidos,
  timeCasaPontos,
  timeVisitanteNome,
  timeVisitanteSetsVencidos,
  timeVisitantePontos,
  jogoEmAndamento,
}
