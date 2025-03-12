import 'package:flutter/material.dart';
import 'package:placar_volei/utils/cache_helper.dart';

final class TemaAppViewModel extends ChangeNotifier {
  final CacheHelper _cacheHelper;
  ThemeMode _tema;

  TemaAppViewModel(this._cacheHelper) : _tema = _cacheHelper.getThemeMode();

  ThemeMode get tema => _tema;

  set tema(ThemeMode tema) {
    if (_tema == tema) {
      return;
    }
    _tema = tema;
    _cacheHelper.setTema(tema);
    notifyListeners();
  }
}
