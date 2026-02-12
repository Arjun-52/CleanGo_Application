import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int maxLines;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixText: prefixText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixTap)
            : null,
        counterText: '',
      ),
    );
  }
}
