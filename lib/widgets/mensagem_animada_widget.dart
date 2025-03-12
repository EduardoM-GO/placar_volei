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
  static const double _increaseSize = 1.5;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    animation = Tween<double>(begin: 0, end: _increaseSize).animate(
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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final text = breakText(
            widget.mensagem,
            widget.tamanho + _increaseSize,
            constraints.maxWidth - 10,
          );
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Text(
              text,
              style: TextStyle(
                color: widget.cor,
                fontSize: widget.tamanho + animation.value,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      );

  String breakText(String text, double fontSize, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final List<String> words = text.split(' ');
    String currentLine = '';
    String finalText = '';

    for (final word in words) {
      final String testLine = '$currentLine $word';

      textPainter.text = TextSpan(
        text: testLine,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();

      if (textPainter.width > maxWidth) {
        finalText += '$currentLine\n';
        currentLine = word;
      } else {
        currentLine = testLine;
      }
    }

    return finalText += currentLine;
  }
}
