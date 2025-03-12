import 'dart:math';

import 'package:flutter/material.dart';
import 'package:placar_volei/models/partida.dart';
import 'package:placar_volei/models/time.dart';
import 'package:placar_volei/models/tipo_time_enum.dart';
import 'package:placar_volei/utils/cache_helper.dart';
import 'package:placar_volei/views_models/tempo_partida_view_model.dart';
import 'package:placar_volei/widgets/dados_inherited_notifier_widget.dart';

final class PartidaViewModel extends ChangeNotifier {
  final CacheHelper _cacheHelper;
  late final TempoPartidaViewModel tempoPartidaController;
  Partida _partida;
  String? _mensagemCasa;
  String? _mensagemVisitante;

  PartidaViewModel(this._cacheHelper) : _partida = _cacheHelper.getPatida() {
    tempoPartidaController = TempoPartidaViewModel(_partida.tempo);
    if (_partida.emAndamento) {
      tempoPartidaController.continuar();
      _verificarVencedor();
    }
  }

  static PartidaViewModel of(BuildContext context) =>
      DadosInheritedNotifierWidget.of(context);

  bool get jogoEmAndamento => _partida.emAndamento;
  String? get mensagemCasa => _mensagemCasa;
  String? get mensagemVisitante => _mensagemVisitante;

  String get placarSets =>
      '${_partida.casa.setsVencidos} x ${_partida.visitante.setsVencidos}';

  Time get timeCasa => _partida.casa;
  Time get timeVisitante => _partida.visitante;

  Future<void> setNomesTime({
    required String nomeCasa,
    required String nomeVisitante,
  }) async {
    _partida = _partida.copyWith(
      casa: _partida.casa.copyWith(nome: nomeCasa),
      visitante: _partida.visitante.copyWith(nome: nomeVisitante),
    );
    await _cacheHelper.setNomesTimes(
      nomeCasa: nomeCasa,
      nomeVisitante: nomeVisitante,
    );
    super.notifyListeners();
  }

  void setEmAndamento({required bool emAndamento}) {
    _partida = _partida.copyWith(emAndamento: emAndamento);
    notifyListeners();
  }

  void setPotuacao({int? pontosCasa, int? pontosVisitante}) {
    late final TipoTimeEnum? time;
    late final bool adicionar;
    if ((pontosCasa ?? 0) != 0) {
      time = TipoTimeEnum.casa;
      adicionar = pontosCasa! > 0;
    } else if ((pontosVisitante ?? 0) != 0) {
      time = TipoTimeEnum.visitante;
      adicionar = pontosVisitante! > 0;
    }

    _partida = _partida.copyWith(
      historicoPotuacao: time != null
          ? _atualizaHistoricoPontuacao(time: time, adicionar: adicionar)
          : null,
      casa: pontosCasa != null
          ? _partida.casa.copyWith(pontos: pontosCasa)
          : null,
      visitante: pontosVisitante != null
          ? _partida.visitante.copyWith(pontos: pontosVisitante)
          : null,
      tempo: tempoPartidaController.tempoDuration,
    );

    _verificarVencedor();

    notifyListeners();
  }

  void _verificarVencedor() {
    final pontoMinimo = 15;
    final casa = _partida.casa;
    final visitante = _partida.visitante;

    if (casa.pontos >= pontoMinimo && (casa.pontos - visitante.pontos) >= 2) {
      _partida = _partida.copyWith(
        casa: _partida.casa.copyWith(setsVencidos: 1),
        emAndamento: false,
        tempo: tempoPartidaController.tempoDuration,
      );
      _mensagemCasa = _mensagemVenceuSet;
      tempoPartidaController.pausar();
      return;
    }
    if (visitante.pontos >= pontoMinimo &&
        (visitante.pontos - casa.pontos) >= 2) {
      _partida = _partida.copyWith(
        visitante: _partida.visitante.copyWith(
          setsVencidos: 1,
        ),
        emAndamento: false,
        tempo: tempoPartidaController.tempoDuration,
      );
      _mensagemVisitante = _mensagemVenceuSet;
      tempoPartidaController.pausar();
      return;
    }

    /// Verificação de Match Point
    if (casa.pontos >= (pontoMinimo - 1) &&
        (casa.pontos - visitante.pontos) >= 1) {
      _mensagemCasa = _mensagemMatchPoint;
      return;
    }
    if (visitante.pontos >= (pontoMinimo - 1) &&
        (visitante.pontos - casa.pontos) >= 1) {
      _mensagemVisitante = _mensagemMatchPoint;
      return;
    }
    _limparMensagens();
  }

  void iniciarJogo() {
    _partida = _partida.copyWith(
      casa: _partida.casa.copyWith(pontos: 0),
      visitante: _partida.visitante.copyWith(pontos: 0),
      historicoPotuacao: [],
      emAndamento: true,
      tempo: tempoPartidaController.tempoDuration,
    );
    _limparMensagens();
    tempoPartidaController.iniciar();

    notifyListeners();
  }

  void resetPlacar() {
    _partida = _partida.copyWith(
      casa: _partida.casa.copyWith(pontos: 0),
      visitante: _partida.visitante.copyWith(pontos: 0),
      tempo: Duration.zero,
      historicoPotuacao: [],
      emAndamento: true,
    );
    tempoPartidaController.resetar();
    _limparMensagens();
    notifyListeners();
  }

  void _limparMensagens() {
    _mensagemCasa = null;
    _mensagemVisitante = null;
  }

  String get _mensagemVenceuSet => _getMensagemAleatoria(_mensagensVenceuSet);

  String get _mensagemMatchPoint => _getMensagemAleatoria(_mensagensMatchPoint);

  String _getMensagemAleatoria(List<String> mensagens) {
    final index = Random().nextInt(mensagens.length - 1);
    return mensagens[index];
  }

  List<TipoTimeEnum> _atualizaHistoricoPontuacao({
    required TipoTimeEnum time,
    required bool adicionar,
  }) {
    final List<TipoTimeEnum> historicoPontuacao =
        _partida.historicoPotuacao.toList();

    if (adicionar) {
      historicoPontuacao.add(time);
    } else {
      final index = historicoPontuacao.lastIndexOf(time);

      if (index != -1) {
        historicoPontuacao.removeAt(index);
      }
    }
    return historicoPontuacao;
  }

  @override
  Future<void> notifyListeners() async {
    await _cacheHelper.setPartida(_partida);
    super.notifyListeners();
  }

  @override
  void dispose() {
    tempoPartidaController.dispose();
    super.dispose();
  }
}

const List<String> _mensagensVenceuSet = [
  'Set fechado! Troca o time e bora de novo!',
  'Deu ruim pra vocês... Troca o time e bora! ',
  'Set ganho! Agora troca aí e vê se melhora!',
  'Faltou entrosamento? Bora trocar os figurantes!',
  'Essa escalação já foi testada e reprovada! Hora da substituição!',
  'Troca o time aí e vê se essa configuração presta!',
  'Troca os bonecos e aperta Start de novo!',
  'Esse time era só beta test? Troca e lança a versão final!',
  'Ganhamos! Mas não fiquem tristes… só troquem!'
];

const List<String> _mensagensMatchPoint = [
  'O Tiro é seu!',
  'EL TIRO! Segura a emoção!',
  'É O TIRO! Quem vai cravar esse ponto?',
  'O TIRO! Última chance de sobreviver!',
  'O TIRO! O jogo está em jogo!',
  'O TIRO! A bola está voando!',
  'Match Point! O próximo ponto pode ser fatal!',
  'É o Tiro! Agora é só esperar o resultado!',
];
