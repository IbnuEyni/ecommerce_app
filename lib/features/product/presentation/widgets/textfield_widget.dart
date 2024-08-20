import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? suffixIcon;

  const CustomTextField(this.label, this.controller,
      {super.key,
      this.keyboardType = TextInputType.text,
      this.suffixIcon,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
