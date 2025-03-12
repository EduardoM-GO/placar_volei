import 'package:placar_volei/models/partida.dart';
import 'package:placar_volei/models/time.dart';
import 'package:placar_volei/models/tipo_time_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class CacheHelper {
  final SharedPreferences _sharedPreferences;

  CacheHelper(this._sharedPreferences);

  Future<void> setPartida(Partida partida) async {
    try {
      await Future.wait([
        _sharedPreferences.setString(
          _CacheKey.nomeTimeCasa.name,
          partida.casa.nome,
        ),
        _sharedPreferences.setString(
          _CacheKey.nomeTimeVisitante.name,
          partida.visitante.nome,
        ),
        _sharedPreferences.setBool(
          _CacheKey.emAndamento.name,
          partida.emAndamento,
        ),
        _sharedPreferences.setStringList(
          _CacheKey.historicoPontuacao.name,
          partida.historicoPotuacao.map((e) => e.name).toList(),
        ),
        _sharedPreferences.setInt(
          _CacheKey.pontosCasa.name,
          partida.casa.pontos,
        ),
        _sharedPreferences.setInt(
          _CacheKey.pontosVisitante.name,
          partida.visitante.pontos,
        ),
        _sharedPreferences.setInt(
          _CacheKey.tempo.name,
          partida.tempo.inSeconds,
        ),
        _sharedPreferences.setInt(
          _CacheKey.setsVencidosCasa.name,
          partida.casa.setsVencidos,
        ),
        _sharedPreferences.setInt(
          _CacheKey.setsVencidosVisitante.name,
          partida.visitante.setsVencidos,
        ),
      ]);
    } catch (_) {}
  }

  Partida getPatida() => Partida(
        casa: Time(
          nome: _sharedPreferences.getString(_CacheKey.nomeTimeCasa.name) ??
              'De lá',
          pontos: _sharedPreferences.getInt(_CacheKey.pontosCasa.name) ?? 0,
          setsVencidos:
              _sharedPreferences.getInt(_CacheKey.setsVencidosCasa.name) ?? 0,
        ),
        visitante: Time(
          nome:
              _sharedPreferences.getString(_CacheKey.nomeTimeVisitante.name) ??
                  'De cá',
          pontos:
              _sharedPreferences.getInt(_CacheKey.pontosVisitante.name) ?? 0,
          setsVencidos:
              _sharedPreferences.getInt(_CacheKey.setsVencidosVisitante.name) ??
                  0,
        ),
        tempo: Duration(
            seconds: _sharedPreferences.getInt(_CacheKey.tempo.name) ?? 0),
        emAndamento:
            _sharedPreferences.getBool(_CacheKey.emAndamento.name) ?? false,
        historicoPotuacao: _historicoPontuacao,
      );

  List<TipoTimeEnum> get _historicoPontuacao {
    final historicoCache =
        _sharedPreferences.getStringList(_CacheKey.historicoPontuacao.name);

    if (historicoCache == null) {
      return [];
    }

    return historicoCache.map((e) => TipoTimeEnum.fromString(e)).toList();
  }
}

enum _CacheKey {
  nomeTimeCasa,
  nomeTimeVisitante,
  setsVencidosCasa,
  setsVencidosVisitante,
  pontosCasa,
  pontosVisitante,
  tempo,
  emAndamento,
  historicoPontuacao,
}
