import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_builder_demo/color_pallet/state/color_theme_state.dart';
import '../models/color_theme.dart';

class ColorThemeCubit extends Cubit<ColorThemeState> {
  ColorThemeCubit() : super(const ColorThemeState()) {
    _initializeData();
  }

  void _initializeData() {
    final systemColors = [
      SystemColor(name: 'Nova', hexColor: '#efefef'),
      SystemColor(name: 'Black', hexColor: '#000000'),
      SystemColor(name: 'Nova', hexColor: '#ffffff'),
      SystemColor(name: 'Nova', hexColor: '#ffffff'),
    ];

    final myColors = [
      ColorTheme(
        name: 'Nova',
        color: '#efefef',
        weight: 'bold',
        size: '16',
      ),
      ColorTheme(
        name: 'Apollo',
        color: '#00000000',
        weight: 'normal',
        size: '12',
      ),
    ];

    emit(state.copyWith(
      systemColors: systemColors,
      myColors: myColors,
    ));
  }

  void addNewColor() {
    final newColor =
        ColorTheme(name: null, color: null, weight: null, size: null);
    final updatedColors = List<ColorTheme>.from(state.myColors)..add(newColor);
    emit(state.copyWith(myColors: updatedColors));
  }

  void updateMyColor(int index, ColorTheme updatedColor) {
    if (index >= 0 && index < state.myColors.length) {
      final updatedColors = List<ColorTheme>.from(state.myColors);
      updatedColors[index] = updatedColor;
      emit(state.copyWith(myColors: updatedColors));
    }
  }

  void removeMyColor(int index) {
    if (index >= 0 && index < state.myColors.length) {
      final updatedColors = List<ColorTheme>.from(state.myColors);
      updatedColors.removeAt(index);
      emit(state.copyWith(myColors: updatedColors));
    }
  }

  // System Colors operations
  void updateSystemColor(int index, SystemColor updatedColor) {
    if (index >= 0 && index < state.systemColors.length) {
      final updatedColors = List<SystemColor>.from(state.systemColors);
      updatedColors[index] = updatedColor;
      emit(state.copyWith(systemColors: updatedColors));
    }
  }

  void addSystemColor(SystemColor newColor) {
    final updatedColors = List<SystemColor>.from(state.systemColors)
      ..add(newColor);
    emit(state.copyWith(systemColors: updatedColors));
  }

  void removeSystemColor(int index) {
    if (index >= 0 && index < state.systemColors.length) {
      final updatedColors = List<SystemColor>.from(state.systemColors);
      updatedColors.removeAt(index);
      emit(state.copyWith(systemColors: updatedColors));
    }
  }

  // Title operations
  void updateSystemColorsTitle(String title) {
    emit(state.copyWith(systemColorsTitle: title));
  }

  void updateMyColorsTitle(String title) {
    emit(state.copyWith(myColorsTitle: title));
  }

  // Utility methods
  void clearAllMyColors() {
    emit(state.copyWith(myColors: []));
  }

  void resetToDefaults() {
    _initializeData();
  }
}
