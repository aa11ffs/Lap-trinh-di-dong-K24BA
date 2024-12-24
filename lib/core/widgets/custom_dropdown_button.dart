import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';

class CustomDropdownButton extends StatefulWidget {
  final String? selectedValue;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?) onChanged;
  final String? hint;
  final bool isRequired;
  final String? Function(String?)? validator;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    this.hint,
    this.isRequired = false,
    this.validator,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          enabledBorder: _buildBorder(AppColor.kDCE1EF, 1),
          focusedBorder: _buildBorder(AppColor.k613BE7, 1),
          errorBorder: _buildBorder(Colors.red, 1),
          focusedErrorBorder: _buildBorder(Colors.red, 1),
        ),
        value: widget.selectedValue,
        hint: Text(widget.hint ?? "Select an option"),
        onChanged: widget.onChanged,
        items: widget.items,
        validator: widget.validator,
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(12.0),
    );
  }
}
