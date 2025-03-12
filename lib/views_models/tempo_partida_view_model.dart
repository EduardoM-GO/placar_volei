import 'dart:async';

import 'package:flutter/material.dart';

class TempoPartidaViewModel extends ChangeNotifier {
  Timer? timer;
  Duration _tempo;

  TempoPartidaViewModel(this._tempo);

  Duration get tempoDuration => _tempo;

  String get tempo =>
      '${_tempo.inMinutes.toString().padLeft(2, '0')}:${_tempo.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  void iniciar() {
    timer?.cancel();
    _tempo = Duration.zero;
    _iniciarTimer();
  }

  void pausar() {
    timer?.cancel();
  }

  void continuar() {
    _iniciarTimer();
  }

  void resetar() {
    timer?.cancel();
    _tempo = Duration.zero;
    notifyListeners();
    _iniciarTimer();
  }

  void _iniciarTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _tempo = Duration(seconds: 1 + _tempo.inSeconds);
        notifyListeners();
      },
    );
  }
}
