enum TipoTimeEnum {
  casa,
  visitante;

  static TipoTimeEnum fromString(String value) => switch (value.toLowerCase()) {
        'casa' => TipoTimeEnum.casa,
        _ => TipoTimeEnum.visitante,
      };
}
