import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int? maxLines;
  final void Function()? onTap;
  final String? hintText;
  final bool expands;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.validator,
    this.readOnly = false,
    this.isPassword = false,
    this.maxLines = 1,
    this.onTap,
    this.suffixIcon,
    this.hintText,
    this.suffix,
    this.expands = false,
    this.fillColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      maxLines: widget.isPassword ? 1 : null,
      validator: widget.validator,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColor.k613BE7,
      expands: widget.expands,
      decoration: InputDecoration(
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(12.0),
        suffix: widget.suffix,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : widget.suffixIcon,
        enabledBorder: _buildBorder(AppColor.kDCE1EF),
        focusedBorder: _buildBorder(AppColor.k613BE7),
        errorBorder: _buildBorder(Colors.red),
        focusedErrorBorder: _buildBorder(Colors.red),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
      borderRadius: BorderRadius.circular(12.0),
    );
  }
}
