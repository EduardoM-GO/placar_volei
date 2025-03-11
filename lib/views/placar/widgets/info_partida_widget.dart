import 'package:flutter/material.dart';
import 'package:placar_volei/controllers/placar_controller.dart';

class InfoPartidaWidget extends StatefulWidget {
  const InfoPartidaWidget({super.key});

  @override
  State<InfoPartidaWidget> createState() => _InfoPartidaWidgetState();
}

class _InfoPartidaWidgetState extends State<InfoPartidaWidget> {
  late PlacarController controller;
  late ColorScheme colorscheme;
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = PlacarController.of(context);
    colorscheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.placarSets,
                style: TextStyle(
                  color: colorscheme.onPrimary,
                  fontSize: 50,
                ),
              ),
              ListenableBuilder(
                listenable: controller.tempoPartidaController,
                builder: (context, _) => Text(
                  controller.tempoPartidaController.tempo,
                  style: TextStyle(
                    color: colorscheme.onPrimary,
                    fontSize: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
