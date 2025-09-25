import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_builder_demo/constant/colors.dart';
import 'package:widget_builder_demo/constant/size_config.dart';
import 'package:widget_builder_demo/color_pallet/components/row_column_layout.dart';
import 'package:widget_builder_demo/color_pallet/state/color_theme_state.dart';
import '../cubits/color_theme_cubit.dart';

class DialogContainer extends StatefulWidget {
  final String title;
  final VoidCallback onClosePressed;

  const DialogContainer({
    super.key,
    required this.title,
    required this.onClosePressed,
  });

  @override
  State<DialogContainer> createState() => _DialogContainerState();
}

class _DialogContainerState extends State<DialogContainer> {
  int _activeTabIndex = 0;
  final TextEditingController _systemColorsTitleController =
      TextEditingController();
  final TextEditingController _myColorsTitleController =
      TextEditingController();

  @override
  void dispose() {
    _systemColorsTitleController.dispose();
    _myColorsTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocBuilder<ColorThemeCubit, ColorThemeState>(
      builder: (context, state) {
        if (_systemColorsTitleController.text != state.systemColorsTitle) {
          _systemColorsTitleController.text = state.systemColorsTitle;
        }
        if (_myColorsTitleController.text != state.myColorsTitle) {
          _myColorsTitleController.text = state.myColorsTitle;
        }

        final List<Map<String, dynamic>> tabsWithContent = [
          {
            "label": "System Colors",
            "content": Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.borderLine,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _systemColorsTitleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: TextStyle(
                              color: AppColors.textHeader.withOpacity(0.66),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          style: TextStyle(
                            color: AppColors.textHeader,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          onChanged: (value) {
                            context
                                .read<ColorThemeCubit>()
                                .updateSystemColorsTitle(value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: AppColors.white.withOpacity(0.66),
                          size: 15,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: RowColumnLayout(
                    headers: [
                      {'title': 'Name', "flex": 2},
                      {'title': 'Hex Colors', "flex": 2},
                    ],
                    isSystemColors: true,
                  ),
                ),
              ],
            ),
          },
          {
            "label": "My Colors",
            "content": Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.borderLine,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _myColorsTitleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: TextStyle(
                              color: AppColors.textHeader.withOpacity(0.66),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          style: TextStyle(
                            color: AppColors.textHeader,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          onChanged: (value) {
                            context
                                .read<ColorThemeCubit>()
                                .updateMyColorsTitle(value);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: AppColors.white.withOpacity(0.66),
                          size: 15,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Expanded(
                  child: RowColumnLayout(
                    headers: [
                      {'title': 'Name', "flex": 2},
                      {'title': 'Color', "flex": 2},
                      {'title': 'Weight', "flex": 2},
                      {'title': 'Size', "flex": 2},
                      {'title': '', "flex": 1},
                    ],
                    isMyColors: true,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          }
        ];

        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                height: SizeConfig.safeBlockVertical * 60,
                width: SizeConfig.blockSizeHorizontal * 50,
                decoration: BoxDecoration(
                  color: AppColors.background,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: AppColors.borderLine,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: AppColors.textHeader,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: AppColors.textHeader,
                              size: 18,
                            ),
                            onPressed: widget.onClosePressed,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 1,
                                    color: AppColors.borderLine,
                                  ),
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: tabsWithContent.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: index == 0
                                        ? const EdgeInsets.only(top: 20)
                                        : EdgeInsets.zero,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _activeTabIndex = index;
                                        });
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 30,
                                          ),
                                          color: _activeTabIndex == index
                                              ? AppColors.white
                                                  .withOpacity(0.05)
                                              : Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                tabsWithContent[index]['label'],
                                                style: TextStyle(
                                                  color: AppColors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Icon(
                                                Icons.chevron_right,
                                                color: AppColors.white
                                                    .withOpacity(0.6),
                                                size: 13,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(20),
                              child: tabsWithContent[_activeTabIndex]
                                  ['content'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
