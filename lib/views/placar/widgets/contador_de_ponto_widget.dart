import 'package:flutter/material.dart';
import 'package:placar_volei/models/time.dart';
import 'package:placar_volei/widgets/mensagem_animada_widget.dart';

class ContadorDePontoWidget extends StatefulWidget {
  final bool ativo;
  final bool timeCasa;
  final Time time;
  final String? mensagem;
  final void Function(int pontos) onChanged;

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
            left: false,
            right: false,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nomeComSets,
                      style: TextStyle(
                        fontSize: size.height * 0.1,
                        color: color,
                      ),
                      maxLines: 1,
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
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.14),
                      child: MensagemAnimadaWidget(
                        mensagem: widget.mensagem!,
                        tamanho: 22,
                        cor: color,
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

  String get nomeComSets {
    if (widget.timeCasa) {
      return '${widget.time.nome} (${widget.time.setsVencidos})';
    } else {
      return '(${widget.time.setsVencidos}) ${widget.time.nome}';
    }
  }

  Future<void> animarPlacar(int pontoAddOrRemove) async {
    await animationController.forward();
    widget.onChanged(pontoAddOrRemove + widget.time.pontos);
  }

  Color get color =>
      widget.timeCasa ? colorScheme.onPrimary : colorScheme.onSecondary;

  Color get colorBackground =>
      widget.timeCasa ? colorScheme.secondary : colorScheme.primary;
}
