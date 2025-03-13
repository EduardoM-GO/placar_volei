import 'package:flutter/material.dart';

class ThemeApp {
  ThemeApp._();

  static ThemeData custom(bool isDark) => ThemeData(
      useMaterial3: true,
      colorScheme: isDark ? _darkColorScheme : _lightColorScheme,
      dividerTheme: const DividerThemeData(
        thickness: 0.2,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ));

  static ColorScheme get _lightColorScheme => ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFFF8C00), // Laranja vibrante (destaca bem no claro)
        onPrimary: Color(0xFFFFFFFF), // Branco puro para contraste
        secondary: Color(0xFF005BBB), // Azul vibrante (cor do céu claro)
        onSecondary: Color(0xFFFFFFFF), // Branco puro
        surface: Color(0xFFFFFFFF), // Branco puro (substituindo background)
        onSurface: Color(0xFF202124), // Preto suave para melhor legibilidade
        surfaceContainerHighest: Color(0xFFFFE5B4), // Bege areia para detalhes
        onSurfaceVariant:
            Color(0xFF3B3B3B), // Cinza escuro para leitura confortável
        error: Color(0xFFD7263D), // Vermelho vibrante para erros
        onError: Color(0xFFFFFFFF), // Branco puro para contraste
      );

  static ColorScheme get _darkColorScheme => ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFFD700), // Amarelo ouro (destaca bem no escuro)
        onPrimary: Color(0xFF1B1F23), // Preto suave para legibilidade
        secondary: Color(0xFF6C8EAD), // Azul acinzentado
        onSecondary: Color(0xFFFFFFFF), // Branco puro para contraste
        surface: Color(0xFF121A25), // Azul escuro (substituindo background)
        onSurface:
            Color(0xFFE0E6EE), // Cinza bem claro (substituindo onBackground)
        surfaceContainerHighest:
            Color(0xFF1E293B), // Fundo secundário para widgets
        onSurfaceVariant: Color(0xFFFFFFFF), // Branco puro para contraste
        error: Color(0xFFFF6B6B), // Vermelho vibrante para erros
        onError: Color(0xFF370617), // Vermelho escuro
      );
}
