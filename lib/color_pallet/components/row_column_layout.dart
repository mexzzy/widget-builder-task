import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:widget_builder_demo/color_pallet/components/dropdown_portal.dart';
import 'package:widget_builder_demo/constant/colors.dart';
import 'package:widget_builder_demo/color_pallet/cubits/color_theme_cubit.dart';
import 'package:widget_builder_demo/color_pallet/state/color_theme_state.dart';
import '../models/color_theme.dart';

class RowColumnLayout extends StatefulWidget {
  final List<Map<String, dynamic>>? headers;
  final List<List<dynamic>>? tableData;
  final List<int>? columnFlex;
  final bool isMyColors;
  final bool isSystemColors;

  const RowColumnLayout({
    super.key,
    this.headers,
    this.tableData,
    this.columnFlex,
    this.isMyColors = false,
    this.isSystemColors = false,
  });

  @override
  State<RowColumnLayout> createState() => _RowColumnLayoutState();
}

class _RowColumnLayoutState extends State<RowColumnLayout> {
  final Map<int, TextEditingController> _nameControllers = {};
  final Map<int, TextEditingController> _colorControllers = {};
  final Map<int, FocusNode> _nameFocusNodes = {};

  @override
  void dispose() {
    for (var controller in _nameControllers.values) {
      controller.dispose();
    }
    for (var controller in _colorControllers.values) {
      controller.dispose();
    }
    for (var node in _nameFocusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  TextEditingController _getNameController(int index, String? initialValue) {
    if (!_nameControllers.containsKey(index)) {
      _nameControllers[index] = TextEditingController(text: initialValue ?? '');
    }
    return _nameControllers[index]!;
  }

  TextEditingController _getColorController(int index, String? initialValue) {
    if (!_colorControllers.containsKey(index)) {
      _colorControllers[index] =
          TextEditingController(text: initialValue ?? '');
    }
    return _colorControllers[index]!;
  }

  FocusNode _getNameFocusNode(int index) {
    if (!_nameFocusNodes.containsKey(index)) {
      _nameFocusNodes[index] = FocusNode();
    }
    return _nameFocusNodes[index]!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ColorThemeCubit, ColorThemeState>(
      listener: (context, state) {
        // Auto-focus the name field for new items
        if (widget.isMyColors && state.myColors.isNotEmpty) {
          final lastIndex = state.myColors.length - 1;
          final lastItem = state.myColors[lastIndex];
          if (lastItem.name == null || lastItem.name!.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _getNameFocusNode(lastIndex).requestFocus();
            });
          }
        }

        // Auto-focus for system colors
        if (widget.isSystemColors && state.systemColors.isNotEmpty) {
          final lastIndex = state.systemColors.length - 1;
          final lastItem = state.systemColors[lastIndex];
          if (lastItem.name == null || lastItem.name!.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _getNameFocusNode(lastIndex).requestFocus();
            });
          }
        }
      },
      builder: (context, state) {
        final data = widget.isMyColors ? state.myColors : state.systemColors;

        return Column(
          children: [
            if (widget.headers != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: AppColors.borderLine,
                  ),
                ),
                child: Row(
                  children: widget.headers!.map((header) {
                    return Expanded(
                      flex: header['flex'] ?? 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            right: header == widget.headers!.last
                                ? BorderSide.none
                                : BorderSide(
                                    width: 1,
                                    color: AppColors.borderLine,
                                  ),
                          ),
                        ),
                        child: Text(
                          header['title'],
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.6),
                          ),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: AppColors.borderLine,
                        ),
                      ),
                      child: Column(
                        children: List.generate(data.length, (rowIndex) {
                          if (widget.isMyColors) {
                            return MyColorRow(
                              index: rowIndex,
                              colorTheme: data[rowIndex] as ColorTheme,
                              nameController: _getNameController(rowIndex,
                                  (data[rowIndex] as ColorTheme).name),
                              focusNode: _getNameFocusNode(rowIndex),
                            );
                          } else {
                            final systemColor = data[rowIndex] as SystemColor;
                            return SystemColorRow(
                              index: rowIndex,
                              systemColor: systemColor,
                              isLastItem: rowIndex == data.length - 1,
                              // Always provide controllers for system colors when isSystemColors is true
                              nameController: widget.isSystemColors
                                  ? _getNameController(
                                      rowIndex, systemColor.name ?? '')
                                  : null,
                              colorController: widget.isSystemColors
                                  ? _getColorController(
                                      rowIndex, systemColor.hexColor ?? '')
                                  : null,
                              focusNode: widget.isSystemColors
                                  ? _getNameFocusNode(rowIndex)
                                  : null,
                            );
                          }
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (widget.isMyColors)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            context.read<ColorThemeCubit>().addNewColor();
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              height: 30,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Add",
                                    style: TextStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (widget.isSystemColors)
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            final newSystemColor = SystemColor(
                              name: null,
                              hexColor: null,
                            );
                            context
                                .read<ColorThemeCubit>()
                                .addSystemColor(newSystemColor);
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              height: 30,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Add",
                                    style: TextStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SystemColorRow extends StatelessWidget {
  final int index;
  final SystemColor systemColor;
  final bool isLastItem;
  final TextEditingController? nameController;
  final TextEditingController? colorController;
  final FocusNode? focusNode;

  const SystemColorRow({
    super.key,
    required this.index,
    required this.systemColor,
    required this.isLastItem,
    this.nameController,
    this.colorController,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLastItem
              ? BorderSide.none
              : BorderSide(
                  width: 1,
                  color: AppColors.borderLine,
                ),
        ),
      ),
      child: Row(
        children: [
          // Name
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: AppColors.borderLine),
                ),
              ),
              child: nameController != null
                  ? TextField(
                      controller: nameController,
                      focusNode: focusNode,
                      style: TextStyle(
                          color: AppColors.white.withOpacity(0.8),
                          fontSize: 12),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter name',
                        hintStyle: TextStyle(
                            color: AppColors.white.withOpacity(0.4),
                            fontSize: 12),
                        isDense: true,
                      ),
                      onChanged: (value) {
                        context.read<ColorThemeCubit>().updateSystemColor(
                              index,
                              SystemColor(
                                  name: value, hexColor: systemColor.hexColor),
                            );
                      },
                    )
                  : Text(
                      systemColor.name ?? '',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
          // Hex Color
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: colorController != null
                        ? TextField(
                            controller: colorController,
                            style: TextStyle(
                                color: AppColors.white.withOpacity(0.8),
                                fontSize: 12),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter hex color',
                              hintStyle: TextStyle(
                                  color: AppColors.white.withOpacity(0.4),
                                  fontSize: 12),
                              isDense: true,
                            ),
                            onChanged: (value) {
                              context.read<ColorThemeCubit>().updateSystemColor(
                                    index,
                                    SystemColor(
                                        name: systemColor.name,
                                        hexColor: value),
                                  );
                            },
                          )
                        : Text(
                            systemColor.hexColor ?? '',
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.6),
                              fontSize: 12,
                            ),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: HexColor('#FFFFFF'),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyColorRow extends StatelessWidget {
  final int index;
  final ColorTheme colorTheme;
  final TextEditingController nameController;
  final FocusNode focusNode;

  static const List<String> _fontSizes = ['12', '16', '20', '24', '32'];
  static const List<String> _fontWeights = [
    'light',
    'normal',
    'medium',
    'bold',
    'black',
  ];

  const MyColorRow({
    super.key,
    required this.index,
    required this.colorTheme,
    required this.nameController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final myColorsLength =
        context.watch<ColorThemeCubit>().state.myColors.length;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: index == myColorsLength - 1
              ? BorderSide.none
              : BorderSide(
                  width: 1,
                  color: AppColors.borderLine,
                ),
        ),
      ),
      child: Row(
        children: [
          // Name
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: AppColors.borderLine),
                ),
              ),
              child: TextField(
                controller: nameController,
                focusNode: focusNode,
                style: TextStyle(
                    color: AppColors.white.withOpacity(0.8), fontSize: 12),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter name',
                  hintStyle: TextStyle(
                      color: AppColors.white.withOpacity(0.4), fontSize: 12),
                  isDense: true,
                ),
                onChanged: (value) {
                  context.read<ColorThemeCubit>().updateMyColor(
                        index,
                        colorTheme.copyWith(name: value),
                      );
                },
              ),
            ),
          ),
          // Color
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: AppColors.borderLine),
                ),
              ),
              child: Center(
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: HexColor('#FFFFFF'),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
          // Weight
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: AppColors.borderLine),
                ),
              ),
              child: DropdownPortal(
                name: "WEIGHT",
                options: _fontWeights,
                selectedValue: colorTheme.weight,
                onChanged: (value) {
                  context.read<ColorThemeCubit>().updateMyColor(
                        index,
                        colorTheme.copyWith(weight: value),
                      );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        colorTheme.weight ?? 'light',
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.white.withOpacity(0.6),
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Size Display
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: AppColors.borderLine),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                colorTheme.size ?? '0',
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Size Dropdown Actions
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              alignment: Alignment.center,
              child: DropdownPortal(
                name: "SIZE",
                options: _fontSizes,
                selectedValue: colorTheme.size,
                onChanged: (value) {
                  context.read<ColorThemeCubit>().updateMyColor(
                        index,
                        colorTheme.copyWith(size: value),
                      );
                },
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.white.withOpacity(0.6),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
