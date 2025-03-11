import 'package:flutter/material.dart';
import 'package:placar_volei/models/time.dart';
import 'package:placar_volei/widgets/mensagem_animada_widget.dart';

class ContadorDePontoWidget extends StatefulWidget {
  final bool ativo;
  final bool timeCasa;
  final Time time;
  final String? mensagem;
  final void Function(Time time) onChanged;

  const ContadorDePontoWidget({
    super.key,
    required this.ativo,
    this.timeCasa = false,
    required this.time,
    required this.mensagem,
    required this.onChanged,
  });

  @override
  State<ContadorDePontoWidget> createState() => _ContadorDePontoWidgetState();
}

class _ContadorDePontoWidgetState extends State<ContadorDePontoWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });
  }

  late ColorScheme colorScheme;
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    colorScheme = Theme.of(context).colorScheme;
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double inicioDeslizeTela = 0;

    return IgnorePointer(
      ignoring: !widget.ativo,
      child: GestureDetector(
        onTap: () {
          animarPlacar(1);
        },
        onVerticalDragStart: (details) {
          inicioDeslizeTela = details.localPosition.dy;
        },
        onVerticalDragEnd: (details) {
          if (inicioDeslizeTela > details.localPosition.dy) {
            animarPlacar(1);
            return;
          }
          animarPlacar(-1);
        },
        child: ColoredBox(
          color: colorBackground,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.time.nome,
                      style: TextStyle(
                        fontSize: size.height * 0.1,
                        color: color,
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        child: ScaleTransition(
                          scale: animation,
                          child: Text(
                            widget.time.pontos.toString(),
                            style: TextStyle(
                              fontSize: size.height,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.mensagem != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MensagemAnimadaWidget(
                        mensagem: widget.mensagem!,
                        tamanho: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> animarPlacar(int pontoAddOrRemove) async {
    await animationController.forward();
    widget.onChanged(
        widget.time.atualizarPontos(pontoAddOrRemove + widget.time.pontos));
  }

  Color get color =>
      widget.timeCasa ? colorScheme.onPrimary : colorScheme.onSecondary;

  Color get colorBackground =>
      widget.timeCasa ? colorScheme.secondary : colorScheme.primary;
}
