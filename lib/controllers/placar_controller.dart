import 'package:flutter/material.dart';
import 'package:placar_volei/controllers/tempo_partida_controller.dart';
import 'package:placar_volei/models/placar.dart';
import 'package:placar_volei/models/time.dart';
import 'package:placar_volei/views/placar/widgets/placar_controller_inherited_notifier_widget.dart';

const String _mensagemVenceuSet = 'Venceu o set!';
const String _mensagemMatchPoint = 'Match Point!';

class PlacarController extends ChangeNotifier {
  final TempoPartidaController tempoPartidaController;
  Placar _placar;
  bool _jogoEmAndamento;
  String? _mensagemCasa;
  String? _mensagemVisitante;

  PlacarController()
      : tempoPartidaController = TempoPartidaController(),
        _placar = Placar.empty(),
        _jogoEmAndamento = false;

  static PlacarController of(BuildContext context) =>
      PlacarControllerInheritedNotifierWidget.of(context);

  void iniciarJogo() {
    _placar = _placar.zerarPontos();
    _jogoEmAndamento = true;
    _mensagemCasa = null;
    _mensagemVisitante = null;
    tempoPartidaController.iniciar();

    notifyListeners();
  }

  bool get jogoEmAndamento => _jogoEmAndamento;
  String? get mensagemCasa => _mensagemCasa;
  String? get mensagemVisitante => _mensagemVisitante;

  String get placarSets =>
      '${_placar.casa.setsVencidos} x ${_placar.visitante.setsVencidos}';

  Time get timeCasa => _placar.casa;
  Time get timeVisitante => _placar.visitante;

  set timeCasa(Time time) {
    if (_naoAtualizarPlacar(timeOrigem: _placar.casa, timeDestino: time)) {
      return;
    }

    _placar = _placar.copyWith(
      casa: time,
    );
    _verificarVencedor();
    notifyListeners();
  }

  set timeVisitante(Time time) {
    if (_naoAtualizarPlacar(timeOrigem: _placar.visitante, timeDestino: time)) {
      return;
    }
    _placar = _placar.copyWith(
      visitante: time,
    );
    _verificarVencedor();
    notifyListeners();
  }

  bool _naoAtualizarPlacar({
    required Time timeOrigem,
    required Time timeDestino,
  }) {
    if (timeOrigem == timeDestino) {
      return true;
    }

    if (timeDestino.pontos < 0) {
      return true;
    }

    return false;
  }

  void _verificarVencedor() {
    final pontoMinimo = 15;
    final casa = _placar.casa;
    final visitante = _placar.visitante;

    if (casa.pontos >= pontoMinimo && (casa.pontos - visitante.pontos) >= 2) {
      _placar = _placar.copyWith(
        casa: _placar.casa.atualizarSetsVencidos(1),
      );

      _jogoEmAndamento = false;
      _mensagemCasa = _mensagemVenceuSet;
      tempoPartidaController.pausar();
      return;
    }
    if (visitante.pontos >= pontoMinimo &&
        (visitante.pontos - casa.pontos) >= 2) {
      _placar = _placar.copyWith(
        visitante: _placar.visitante.atualizarSetsVencidos(1),
      );
      _jogoEmAndamento = false;
      _mensagemVisitante = _mensagemVenceuSet;
      tempoPartidaController.pausar();
      return;
    }

    // Verificação de Match Point
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
    _mensagemCasa = null;
    _mensagemVisitante = null;
  }

  void resetPlacar() {
    _placar = _placar.copyWith(
      casa: _placar.casa.atualizarPontos(0),
      visitante: _placar.visitante.atualizarPontos(0),
    );
    tempoPartidaController.resetar();
    notifyListeners();
  }
}
