import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:widget_builder_demo/constant/colors.dart';

class DropdownPortal extends StatefulWidget {
  final List<String> options;
  final String? selectedValue;
  final String? name;
  final Function(String) onChanged;
  final Widget child;

  const DropdownPortal({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.name,
    required this.onChanged,
    required this.child,
  });

  @override
  State<DropdownPortal> createState() => _DropdownPortalState();
}

class _DropdownPortalState extends State<DropdownPortal> {
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _closeDropdown() {
    setState(() {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: _isOpen,
      closeDuration: kThemeAnimationDuration,
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _closeDropdown,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      child: PortalTarget(
        visible: _isOpen,
        anchor: const Aligned(
          follower: Alignment.topCenter,
          target: Alignment.bottomLeft,
        ),
        portalFollower: Container(
          constraints: const BoxConstraints(
            minWidth: 120,
            maxWidth: 450,
          ),
          decoration: BoxDecoration(
            color: HexColor("#222324"),
            border: Border.all(
              color: HexColor("#323436"),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 15,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            childAspectRatio: 3.5,
            children: widget.options.map((option) {
              final isSelected = option == widget.selectedValue;
              return GestureDetector(
                onTap: () {
                  widget.onChanged(option);
                  _closeDropdown();
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#262728"),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: HexColor("#2F2F2F"),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name ?? "",
                            style: TextStyle(
                              color: HexColor("#848484"),
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primary
                                  : HexColor("#D7D5D5"),
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )),
              );
            }).toList(),
          ),
        ),
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
