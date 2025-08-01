import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.suffix,
    this.validator,
    this.icon,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.prefixIconColor,
    this.onTap,
    this.readOnly,
  });

  final String label;
  final TextEditingController? controller;
  final bool? suffix;
  final bool obscureText;
  final IconButton? suffixIcon;
  final TextInputType? keyboardType;
  final IconData? icon;
  final Color? prefixIconColor;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        child: TextFormField(
          style: TextStyle(
            fontFamily: 'Cairo-Bold',
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onTap: onTap,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          cursorColor: AppColor.kPrimaryColor,
          decoration: InputDecoration(
            errorMaxLines: 3,
            suffixIcon: suffixIcon,
            prefixIcon: icon != null
                ? Icon(icon, color: AppColor.kPrimaryColor)
                : null,
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            labelText: label,
            labelStyle: const TextStyle(
              color: AppColor.kPrimaryColor,
              fontFamily: 'Cairo-Bold',
              fontSize: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
        ),
      ),
    );
  }
}
