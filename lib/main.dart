import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placar_volei/utils/theme_app.dart';
import 'package:placar_volei/views/placar/placar_view.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
    [
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]),
      WakelockPlus.enable()
    ],
  );
  runApp(const MainApp());
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
