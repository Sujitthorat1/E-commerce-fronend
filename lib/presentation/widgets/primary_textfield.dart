import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
//this initial value and the onChange method is defined for the edit user profile
  final String? initialValue;
  final Function(String)? onChanged;
  const PrimaryTextField(
      {super.key,
      required this.labelText,
      this.controller,
      this.validator,
      this.initialValue,
      this.onChanged,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged:onChanged,
      initialValue: initialValue,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
          labelText: labelText),
    );
  }
}
