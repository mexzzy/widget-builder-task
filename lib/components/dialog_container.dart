import 'package:flutter/material.dart';
import 'package:widget_builder_demo/constant/colors.dart';
import 'package:widget_builder_demo/constant/size_config.dart';

class DialogContainer extends StatefulWidget {
  final String title;
  final VoidCallback onClosePressed;
  final List<Map<String, dynamic>> tabsWithContent;

  const DialogContainer({
    super.key,
    required this.title,
    required this.onClosePressed,
    required this.tabsWithContent,
  });

  @override
  State<DialogContainer> createState() => _DialogContainerState();
}

class _DialogContainerState extends State<DialogContainer> {
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                            itemCount: widget.tabsWithContent.length,
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
                                          ? AppColors.white.withOpacity(0.05)
                                          : Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.tabsWithContent[index]
                                                ['label'],
                                            style: TextStyle(
                                              color:
                                                  AppColors.white.withOpacity(
                                                0.6,
                                              ),
                                              fontSize: 13,
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: AppColors.white.withOpacity(
                                              0.6,
                                            ),
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
                          child: widget.tabsWithContent[_activeTabIndex]
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
  }
}
