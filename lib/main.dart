import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:placar_volei/utils/cache_helper.dart';
import 'package:placar_volei/utils/theme_app.dart';
import 'package:placar_volei/views/configuracao/configuracao_view.dart';
import 'package:placar_volei/views/placar/placar_view.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';
import 'package:placar_volei/views_models/tema_app_view_model.dart';
import 'package:placar_volei/widgets/dados_inherited_notifier_widget.dart';
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
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky),
      WakelockPlus.enable()
    ],
  );
  final shared = await SharedPreferences.getInstance();
  final cacheHelper = CacheHelper(shared);
  FlutterNativeSplash.remove();

  runApp(
    DadosInheritedNotifierWidget(
      notifier: PartidaViewModel(cacheHelper),
      temaAppViewModel: TemaAppViewModel(cacheHelper),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModeNotifier =
        DadosInheritedNotifierWidget.ofThemeModeNotifier(context);

    return AnimatedBuilder(
      animation: themeModeNotifier,
      builder: (context, _) => MaterialApp(
          home: PlacarView(),
          themeMode: themeModeNotifier.tema,
          theme: ThemeApp.custom(false),
          darkTheme: ThemeApp.custom(true),
          initialRoute: '/home',
          routes: {
            '/home': (context) => const PlacarView(),
            '/configuracao': (context) => const ConfiguracaoView(),
          }),
    );
  }
}
