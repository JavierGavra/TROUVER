import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavbarItem extends StatefulWidget {
  const NavbarItem(
      {super.key,
      required this.icon,
      required this.iconSelcted,
      required this.indexItem,
      required this.index,
      required this.message,
      required this.onChangedTab});
  final IconData icon;
  final IconData iconSelcted;
  final int index;
  final int indexItem;
  final String message;
  final ValueChanged<int> onChangedTab;

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.indexItem == widget.index;
    return InkWell(
      onTap: () {
        widget.onChangedTab(widget.indexItem);
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        height: 40.h,
        width: 80.w,
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: ColorApp.accentColor,
              )
            : null,
        child: Tooltip(
          message: widget.message,
          child: Icon(
            isSelected ? widget.iconSelcted : widget.icon,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
