import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DropdownField<T> extends StatefulWidget {
  final int elevation;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final Widget Function(T)? itemBuilder;
  final double height;
  final String hint;
  final T? selectedValue;
  final bool isDisabled;

  const DropdownField({
    super.key,
    this.elevation = 16,
    required this.items,
    required this.onChanged,
    this.itemBuilder,
    this.height = 55.0, required this.hint,
    this.selectedValue, this.isDisabled = false,
  });

  @override
  State<DropdownField<T>> createState() => DropdownFieldState<T>();
}

class DropdownFieldState<T> extends State<DropdownField<T>> {
  T? selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, top: 1.h, bottom: 1.h, right: 15.w),
      height: widget.height.h,
      decoration: BoxDecoration(
          color: AppColors.foregroundColor,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
      child: DropdownButton<T>(
        value: selectedValue,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
        ),
        isExpanded: true,
        elevation: widget.elevation,
        style: TextStyle(fontSize: 15.w,color: Colors.white),
        borderRadius: BorderRadius.circular(12.r),
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.foregroundColor,
        onChanged: widget.isDisabled ? null : (value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChanged(value);
        },
        hint: Text(
          widget.hint,
          style: TextStyle(fontSize: 15.w,color: Colors.grey),
        ),
        items: widget.items.map<DropdownMenuItem<T>>((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: widget.itemBuilder != null ? widget.itemBuilder!(item) : Text('$item',style:TextStyle(fontSize: 15.w,color: Colors.white) ,),
          );
        }).toList(),
      ),
    );
  }

  reset(){
    setState(() {
      selectedValue = null;
    });
  }
}
