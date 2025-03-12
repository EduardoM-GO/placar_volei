import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:placar_volei/utils/cache_helper.dart';
import 'package:placar_volei/utils/theme_app.dart';
import 'package:placar_volei/views/placar/placar_view.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';
import 'package:placar_volei/widgets/partida_inherited_notifier_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.wait(
    [
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]),
      WakelockPlus.enable()
    ],
  );
  final shared = await SharedPreferences.getInstance();
  final cacheHelper = CacheHelper(shared);
  FlutterNativeSplash.remove();

  runApp(
    PartidaInheritedNotifierWidget(
      notifier: PartidaViewModel(cacheHelper),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: PlacarView(),
        theme: ThemeApp.custom(false),
        darkTheme: ThemeApp.custom(true),
      );
}
