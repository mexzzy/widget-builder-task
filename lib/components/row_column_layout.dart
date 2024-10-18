import 'package:flutter/material.dart';
import 'package:widget_builder_demo/constant/colors.dart';

class RowColumnLayout extends StatefulWidget {
  final List<Map<String, dynamic>>? headers;
  final List<List<dynamic>> tableData;
  final List<int>? columnFlex;

  const RowColumnLayout({
    super.key,
    this.headers,
    required this.tableData,
    this.columnFlex,
  });

  @override
  State<RowColumnLayout> createState() => _RowColumnLayoutState();
}

class _RowColumnLayoutState extends State<RowColumnLayout> {
  @override
  Widget build(BuildContext context) {
    int columnCount = widget.headers?.length ?? widget.tableData.first.length;

    List columnFlex = widget.headers != null
        ? widget.headers!.map((header) => header['flex'] ?? 1).toList()
        : widget.columnFlex ?? List<int>.filled(columnCount, 1);

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
                      vertical: 5,
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
                    children:
                        List.generate(widget.tableData.length, (rowIndex) {
                      List<dynamic> row = widget.tableData[rowIndex];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: rowIndex == widget.tableData.length - 1
                                ? BorderSide.none
                                : BorderSide(
                                    width: 1,
                                    color: AppColors.borderLine,
                                  ),
                          ),
                        ),
                        child: Row(
                          children: List.generate(row.length, (index) {
                            return Expanded(
                              flex: columnFlex[index],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: index == row.length - 1
                                        ? BorderSide.none
                                        : BorderSide(
                                            width: 1,
                                            color: AppColors.borderLine,
                                          ),
                                  ),
                                ),
                                child: row[index] is Widget
                                    ? row[index]
                                    : Text(
                                        row[index].toString(),
                                        style: TextStyle(
                                          color:
                                              AppColors.white.withOpacity(0.6),
                                        ),
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {},
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
