import 'package:equatable/equatable.dart';
import '../models/color_theme.dart';

class ColorThemeState extends Equatable {
  final List<ColorTheme> myColors;
  final List<SystemColor> systemColors;
  final String systemColorsTitle;
  final String myColorsTitle;

  const ColorThemeState({
    this.myColors = const [],
    this.systemColors = const [],
    this.systemColorsTitle = 'System Colors',
    this.myColorsTitle = 'My Colors',
  });

  ColorThemeState copyWith({
    List<ColorTheme>? myColors,
    List<SystemColor>? systemColors,
    String? systemColorsTitle,
    String? myColorsTitle,
  }) {
    return ColorThemeState(
      myColors: myColors ?? this.myColors,
      systemColors: systemColors ?? this.systemColors,
      systemColorsTitle: systemColorsTitle ?? this.systemColorsTitle,
      myColorsTitle: myColorsTitle ?? this.myColorsTitle,
    );
  }

  @override
  List<Object?> get props =>
      [myColors, systemColors, systemColorsTitle, myColorsTitle];
}
