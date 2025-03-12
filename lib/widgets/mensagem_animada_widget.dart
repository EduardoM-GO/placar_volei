import 'package:flutter/material.dart';

class MensagemAnimadaWidget extends StatefulWidget {
  final String mensagem;
  final double tamanho;
  final Color cor;
  const MensagemAnimadaWidget({
    super.key,
    required this.mensagem,
    required this.tamanho,
    required this.cor,
  });

  @override
  State<MensagemAnimadaWidget> createState() => _MensagemAnimadaWidgetState();
}

class _MensagemAnimadaWidgetState extends State<MensagemAnimadaWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    animation = Tween<double>(begin: 0, end: 1.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Text(
          widget.mensagem,
          style: TextStyle(
            color: widget.cor,
            fontSize: widget.tamanho + animation.value,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
