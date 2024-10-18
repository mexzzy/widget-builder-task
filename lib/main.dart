import 'package:flutter/material.dart';
import 'package:widget_builder_demo/components/dialog_container.dart';
import 'package:widget_builder_demo/components/row_column_layout.dart';
import 'package:widget_builder_demo/constant/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabsWithContent = [
      {
        "label": "System Colors",
        "content": Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
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
                  {'title': 'Name', "flex": 3},
                  {'title': 'Hex Colors', "flex": 2},
                  {'title': 'Weight', "flex": 2},
                ],
                tableData: [
                  ['Nova', '#efefef', 'bold'],
                  ['Apollo', '#00000000', 'normal weight'],
                  ['Nova', '#ffffff', 'bold'],
                  ['Nova', '#ffffff', 'bold'],
                ],
              ),
            ),
          ],
        ),
      },
      {
        "label": "My Text Theme",
        "content": Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
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
                tableData: [
                  ['Nova', '#efefef', 'bold', '16'],
                  ['Apollo', '#00000000', 'normal weight', '12'],
                  ['Nova', '#ffffff', 'bold', '16'],
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      }
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      home: DialogContainer(
        title: 'Color Pallet',
        onClosePressed: () {},
        tabsWithContent: tabsWithContent,
      ),
    );
  }
}
