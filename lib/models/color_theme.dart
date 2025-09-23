class ColorTheme {
  final String? name;
  final String? color;
  final String? weight;
  final String? size;

  ColorTheme({
    this.name,
    this.color,
    this.weight,
    this.size,
  });

  ColorTheme copyWith({
    String? name,
    String? color,
    String? weight,
    String? size,
  }) {
    return ColorTheme(
      name: name ?? this.name,
      color: color ?? this.color,
      weight: weight ?? this.weight,
      size: size ?? this.size,
    );
  }
}

class SystemColor {
  final String? name;
  final String? hexColor;

  SystemColor({
    this.name,
    this.hexColor,
  });

  SystemColor copyWith({
    String? name,
    String? hexColor,
  }) {
    return SystemColor(
      name: name ?? this.name,
      hexColor: hexColor ?? this.hexColor,
    );
  }
}