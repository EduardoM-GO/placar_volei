import 'package:flutter/material.dart';

class ThemeApp {
  ThemeApp._();

  static ThemeData custom(bool isDark) => ThemeData(
        useMaterial3: true,
        colorScheme: isDark ? _darkColorScheme : _lightColorScheme,
        dividerTheme: const DividerThemeData(
          thickness: 0.2,
        ),
      );

  static ColorScheme get _lightColorScheme => ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF006874), // Cor primária (azul-petróleo)
        onPrimary: Color(0xFFFFFFFF), // Cor do texto sobre a primária
        primaryContainer: Color(0xFF95F9FF), // Container da cor primária
        onPrimaryContainer:
            Color(0xFF001F24), // Cor do texto sobre o container da primária
        secondary: Color(0xFF4B6268), // Cor secundária (cinza-azulado)
        onSecondary: Color(0xFFFFFFFF), // Cor do texto sobre a secundária
        secondaryContainer: Color(0xFFCDE7EF), // Container da cor secundária
        onSecondaryContainer:
            Color(0xFF071E24), // Cor do texto sobre o container da secundária
        tertiary:
            Color(0xFF565E71), // Cor terciária (cinza-azulado mais escuro)
        onTertiary: Color(0xFFFFFFFF), // Cor do texto sobre a terciária
        tertiaryContainer: Color(0xFFDAE2F9), // Container da cor terciária
        onTertiaryContainer:
            Color(0xFF131B2C), // Cor do texto sobre o container da terciária
        error: Color(0xFFBA1A1A), // Cor de erro (vermelho)
        errorContainer: Color(0xFFFFDAD6), // Container da cor de erro
        onError: Color(0xFFFFFFFF), // Cor do texto sobre a cor de erro
        onErrorContainer: Color(0xFF410002), // Cor do texto sobre o fundo
        surface: Color(0xFFFBFCFE), // Cor da superfície (branco)
        onSurface: Color(0xFF191C1D), // Cor do texto sobre a superfície
        surfaceContainerHighest:
            Color(0xFFDCE3E5), // Variação da cor da superfície
        onSurfaceVariant:
            Color(0xFF40484B), // Cor do texto sobre a variação da superfície
        outline: Color(0xFF70787B), // Cor do contorno
        onInverseSurface:
            Color(0xFFF0F1F3), // Cor do texto sobre a superfície inversa
        inverseSurface: Color(0xFF2E3132), // Superfície inversa
        inversePrimary: Color(0xFF4FD8EB), // Primária inversa
        shadow: Color(0xFF000000), // Cor da sombra
      );

  static ColorScheme get _darkColorScheme => ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF4FD8EB), // Cor primária (azul-petróleo claro)
        onPrimary: Color(0xFF00363D), // Cor do texto sobre a primária
        primaryContainer: Color(0xFF004F57), // Container da cor primária
        onPrimaryContainer:
            Color(0xFF95F9FF), // Cor do texto sobre o container da primária
        secondary: Color(0xFFB2CBD2), // Cor secundária (cinza-azulado claro)
        onSecondary: Color(0xFF1D3439), // Cor do texto sobre a secundária
        secondaryContainer: Color(0xFF334A50), // Container da cor secundária
        onSecondaryContainer:
            Color(0xFFCDE7EF), // Cor do texto sobre o container da secundária
        tertiary: Color(0xFFBEC6DD), // Cor terciária (cinza-azulado mais claro)
        onTertiary: Color(0xFF283041), // Cor do texto sobre a terciária
        tertiaryContainer: Color(0xFF3F4759), // Container da cor terciária
        onTertiaryContainer:
            Color(0xFFDAE2F9), // Cor do texto sobre o container da terciária
        error: Color(0xFFFFB4AB), // Cor de erro (vermelho claro)
        errorContainer: Color(0xFF93000A), // Container da cor de erro
        onError: Color(0xFF690005), // Cor do texto sobre a cor de erro
        onErrorContainer: Color(0xFFFFDAD6), // Cor do texto sobre o fundo
        surface: Color(0xFF191C1D), // Cor da superfície (preto)
        onSurface: Color(0xFFE1E2E4), // Cor do texto sobre a superfície
        surfaceContainerHighest:
            Color(0xFF40484B), // Variação da cor da superfície
        onSurfaceVariant:
            Color(0xFFC0C8CB), // Cor do texto sobre a variação da superfície
        outline: Color(0xFF8A9295), // Cor do contorno
        onInverseSurface:
            Color(0xFF191C1D), // Cor do texto sobre a superfície inversa
        inverseSurface: Color(0xFFE1E2E4), // Superfície inversa
        inversePrimary: Color(0xFF006874), // Primária inversa
        shadow: Color(0xFF000000), // Cor da sombra
      );
}
